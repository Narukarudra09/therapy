import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_role.dart';

class AuthProvider with ChangeNotifier {
  UserRoles? _selectedUser;
  bool _isLoading = false;
  String? _verificationId;
  UserRole? _pendingRole;

  UserRoles? get selectedUser => _selectedUser;
  bool get isLoading => _isLoading;
  UserRole? get pendingRole => _pendingRole;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      return true; // Return true if the OTP is sent successfully
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false; // Return false if there is an error
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

      // Set the selected user based on the role
      switch (_pendingRole) {
        case UserRole.superAdmin:
          _selectedUser = UserRoles(
            id: '1',
            name: 'Super Admin',
            role: UserRole.superAdmin,
            phoneNumber: '',
          );
          break;
        case UserRole.centerOwner:
          _selectedUser = UserRoles(
            id: '2',
            name: 'Center Owner',
            role: UserRole.centerOwner,
            phoneNumber: '',
          );
          break;
        case UserRole.therapist:
          _selectedUser = UserRoles(
            id: '3',
            name: 'Therapist',
            role: UserRole.therapist,
            phoneNumber: '',
          );
          break;
        case UserRole.patient:
          _selectedUser = UserRoles(
            id: '4',
            name: 'Patient',
            role: UserRole.patient,
            phoneNumber: '',
          );
          break;
        case null:
          // TODO: Handle this case.
          throw UnimplementedError();
      }

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
