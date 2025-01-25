import 'package:flutter/material.dart';

import '../models/user_role.dart';

class AuthProvider extends ChangeNotifier {
  UserRoles? _selectedUser;
  bool _isLoading = false;
  String? pendingPhoneNumber;
  UserRole? pendingRole;

  UserRoles? get selectedUser => _selectedUser;

  bool get isLoading => _isLoading;

  // Simulated login process to initiate OTP
  Future<bool> login(UserRole role, String phoneNumber) async {
    _isLoading = true;
    pendingRole = role;
    pendingPhoneNumber = phoneNumber;
    notifyListeners();

    try {
      // Simulate OTP sending process
      await Future.delayed(Duration(seconds: 1));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // OTP verification method
  Future<bool> verifyOtp(
      {required String phoneNumber,
      required String otp,
      required UserRole role}) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    // Simulate OTP verification
    if (otp == '123456') {
      // Create user based on selected role
      switch (role) {
        case UserRole.superAdmin:
          _selectedUser = UserRoles(
              id: '1', name: 'Super Admin', role: UserRole.superAdmin);
          break;
        case UserRole.centerOwner:
          _selectedUser = UserRoles(
              id: '2', name: 'Center Owner', role: UserRole.centerOwner);
          break;
        case UserRole.therapist:
          _selectedUser =
              UserRoles(id: '3', name: 'Therapist', role: UserRole.therapist);
          break;
        case UserRole.patient:
          _selectedUser =
              UserRoles(id: '4', name: 'Patient', role: UserRole.patient);
          break;
      }

      _isLoading = false;
      pendingPhoneNumber = null;
      pendingRole = null;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _selectedUser = null;
    pendingPhoneNumber = null;
    pendingRole = null;
    notifyListeners();
  }
}
