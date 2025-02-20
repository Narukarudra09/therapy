import 'package:flutter/material.dart';

import '../models/user_role.dart';

class AuthProvider with ChangeNotifier {
  UserRoles? _selectedUser;
  bool _isLoading = false;
  String? _pendingPhoneNumber;
  UserRole? _pendingRole;

  UserRoles? get selectedUser => _selectedUser;

  bool get isLoading => _isLoading;

  String? get pendingPhoneNumber => _pendingPhoneNumber;

  UserRole? get pendingRole => _pendingRole;

  Future<bool> login(UserRole role, String phoneNumber) async {
    _isLoading = true;
    _pendingRole = role;
    _pendingPhoneNumber = phoneNumber;
    notifyListeners();

    try {
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

  Future<bool> verifyOtp({
    required String phoneNumber,
    required String otp,
    required UserRole role,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    if (otp == '123456') {
      switch (role) {
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
      }

      _isLoading = false;
      _pendingPhoneNumber = null;
      _pendingRole = null;
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
    _pendingPhoneNumber = null;
    _pendingRole = null;
    notifyListeners();
  }
}
