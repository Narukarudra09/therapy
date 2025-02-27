import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _selectedUser;
  bool _isLoading = false;
  String? _verificationId;
  String? _userType; // Store the user type

  String? get selectedUser => _selectedUser;

  bool get isLoading => _isLoading;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String phoneNumber, String userType) async {
    _isLoading = true;
    _userType = userType; // Store the user type
    notifyListeners();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          await _addUserToFirestore(phoneNumber, userType);
          _completeLogin();
        },
        verificationFailed: (FirebaseAuthException e) {
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
      return false;
    }
  }

  Future<void> _addUserToFirestore(String phoneNumber, String userType) async {
    await _firestore.collection('Users').doc(phoneNumber).set({
      'phoneNumber': phoneNumber,
      'userType': userType,
    });
  }

  Future<bool> verifyOtp(String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      await _addUserToFirestore(_auth.currentUser!.phoneNumber!, _userType!);
      _completeLogin();
      return true;
    } catch (e) {
      _handleLoginError(e);
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

  void logout() {
    _selectedUser = null;
    _verificationId = null;
    _userType = null;
    _auth.signOut();
    notifyListeners();
  }
}
