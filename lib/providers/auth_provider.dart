import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therapy/models/center_owner.dart';

import 'package:therapy/models/patient.dart';
import 'package:therapy/models/super_admin.dart';
import 'package:therapy/models/therapist.dart';
import '../models/user_role.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _selectedUser;
  bool _isLoading = false;
  String? _verificationId;
  String _selectedRole = 'Super Admin';
  String? _error;
  String? get error => _error;

  UserModel? get selectedUser => _selectedUser;

  bool get isLoading => _isLoading;

  String get selectedRole => _selectedRole;

  String? get verificationId => _verificationId;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String phoneNumber, String userType) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _selectedUser = await getUserFromFirestore(phoneNumber, userType);
          _completeLogin();
        },
        verificationFailed: (FirebaseAuthException e) {
          _error = e.message;
          _isLoading = false;
          notifyListeners();
          throw Exception('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _isLoading = false;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
      return true;
    } catch (e) {
      _handleLoginError(e);
      _error = e.toString();
      _isLoading = false;
      return false;
    }
  }

  Future<bool> verifyOtp(String otp, String userType) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (_verificationId == null) {
        throw Exception('Verification ID not found');
      }

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      _selectedUser = await getUserFromFirestore(
        _auth.currentUser!.phoneNumber!,
        userType,
      );

      final phoneNumber = _auth.currentUser!.phoneNumber!;
      final userDoc = await _firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .get();

      if (!userDoc.exists) {
        // Create new user based on userType
        switch (userType) {
          case 'patient':
            await _firestore
                .collection('Users')
                .doc(phoneNumber)
                .collection('data')
                .doc('info')
                .set(Patient(phone: phoneNumber).toMap());
            break;

          case 'therapist':
            await _firestore
                .collection('Users')
                .doc(phoneNumber)
                .collection('data')
                .doc('info')
                .set(Therapist(phoneNumber: phoneNumber).toMap());
            break;

          case 'center_owner':
            await _firestore
                .collection('Users')
                .doc(phoneNumber)
                .collection('data')
                .doc('info')
                .set(CenterOwner(phoneNumber: phoneNumber).toMap());
            break;

          case 'super_admin':
            await _firestore
                .collection('Users')
                .doc(phoneNumber)
                .collection('data')
                .doc('info')
                .set(SuperAdmin(phoneNumber: phoneNumber).toMap());
            break;
        }
      }

      await saveToPrefs();
      _completeLogin();
      return true;
    } catch (e) {
      _handleLoginError(e);
      return false;
    }
  }

  Future<UserModel> getUserFromFirestore(
      String phoneNumber, String userType) async {
    DocumentSnapshot doc =
        await _firestore.collection('Users').doc(phoneNumber).get();
    if (doc.exists) {
      UserModel user = UserModel.fromDocument(doc);
      if (user.userType != userType) {
        throw Exception('Incorrect user type');
      }

      return user;
    } else {
      // Add the user to Firestore if not found
      await _firestore.collection('Users').doc(phoneNumber).set({
        'phoneNumber': phoneNumber,
        'userType': userType,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Create initial data based on user type
      await _firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .set({
        'phoneNumber': phoneNumber,
        'userType': userType,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Fetch the newly added user
      DocumentSnapshot newDoc =
          await _firestore.collection('Users').doc(phoneNumber).get();
      return UserModel.fromDocument(newDoc);
    }
  }

  Future<bool> isUserTypeCorrect(String phoneNumber, String userType) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('Users').doc(phoneNumber).get();
      if (doc.exists) {
        UserModel user = UserModel.fromDocument(doc);
        return user.userType == userType;
      } else {
        // Add the user to Firestore if not found
        await _firestore.collection('Users').doc(phoneNumber).set({
          'phoneNumber': phoneNumber,
          'userType': userType,
          // Add other fields as necessary
        });
        // Return true because the user is now added with the correct userType
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void _completeLogin() {
    _isLoading = false;
    _verificationId = null;
    notifyListeners();
  }

  void _handleLoginError(dynamic e) {
    _isLoading = false;
    notifyListeners();
    throw Exception('Login failed: $e');
  }

  Future<void> saveToPrefs() async {
    if (_selectedUser != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userPhone', _selectedUser!.phoneNumber);
      await prefs.setString('userType', _selectedUser!.userType);
    }
  }

  Future<bool> loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final phone = prefs.getString('userPhone');
      final userType = prefs.getString('userType');

      if (phone != null && userType != null) {
        _selectedUser = UserModel(
          phoneNumber: phone,
          userType: userType,
        );
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error loading preferences: $e');
      return false;
    }
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> logout() async {
    await clearPrefs();
    _selectedUser = null;
    _verificationId = null;
    await _auth.signOut();
    notifyListeners();
  }

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}
