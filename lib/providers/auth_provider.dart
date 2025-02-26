import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_role.dart';

class AuthProvider with ChangeNotifier {
  dynamic _selectedUser;
  bool _isLoading = false;
  String? _verificationId;
  UserRole? _pendingRole;

  dynamic get selectedUser => _selectedUser;
  bool get isLoading => _isLoading;
  UserRole? get pendingRole => _pendingRole;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(UserRole role, String phoneNumber) async {
    _isLoading = true;
    _pendingRole = role;
    notifyListeners();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _isLoading = false;
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException e) {
          _isLoading = false;
          notifyListeners();
          throw Exception(e.message);
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
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp({required String otp}) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      String uid = userCredential.user!.uid;

      // Fetch user data from Firestore based on the role
      // DocumentSnapshot userDoc;
      // switch (_pendingRole) {
      //   case UserRole.superAdmin:
      //     userDoc = await _firestore.collection('superAdmins').doc(uid).get();
      //     _selectedUser = SuperAdmin.fromFirestore(userDoc.data() as Map<String, dynamic>);
      //     break;
      //   case UserRole.centerOwner:
      //     userDoc = await _firestore.collection('centerOwners').doc(uid).get();
      //     _selectedUser = CenterOwner.fromFirestore(userDoc.data() as Map<String, dynamic>);
      //     break;
      //   case UserRole.therapist:
      //     userDoc = await _firestore.collection('therapists').doc('3').get();
      //     _selectedUser = Therapist.fromFirestore(userDoc.data() as Map<String, dynamic>);
      //     break;
      //   case UserRole.patient:
      //     userDoc = await _firestore.collection('patients').doc('4').get();
      //     _selectedUser = Patient.fromFirestore(userDoc.data() as Map<String, dynamic>);
      //     break;
      //   case null:
      //     throw UnimplementedError();
      // }

      _isLoading = false;
      _verificationId = null;
      _pendingRole = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _selectedUser = null;
    _verificationId = null;
    _pendingRole = null;
    _auth.signOut();
    notifyListeners();
  }
}
