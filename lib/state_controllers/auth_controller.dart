import 'package:get/get.dart';

import '../models/user_role.dart';

class AuthController extends GetxController {
  var selectedUser = Rxn<UserRoles>();
  var isLoading = false.obs;
  var pendingPhoneNumber = Rxn<String>();
  var pendingRole = Rxn<UserRole>();

  Future<bool> login(UserRole role, String phoneNumber) async {
    isLoading(true);
    pendingRole(role);
    pendingPhoneNumber(phoneNumber);

    try {
      await Future.delayed(Duration(seconds: 1));
      isLoading(false);
      return true;
    } catch (e) {
      isLoading(false);
      return false;
    }
  }

  Future<bool> verifyOtp({
    required String phoneNumber,
    required String otp,
    required UserRole role,
  }) async {
    isLoading(true);

    await Future.delayed(Duration(seconds: 1));

    if (otp == '123456') {
      switch (role) {
        case UserRole.superAdmin:
          selectedUser(UserRoles(
            id: '1',
            name: 'Super Admin',
            role: UserRole.superAdmin,
            phoneNumber: '',
          ));
          break;
        case UserRole.centerOwner:
          selectedUser(UserRoles(
            id: '2',
            name: 'Center Owner',
            role: UserRole.centerOwner,
            phoneNumber: '',
          ));
          break;
        case UserRole.therapist:
          selectedUser(UserRoles(
            id: '3',
            name: 'Therapist',
            role: UserRole.therapist,
            phoneNumber: '',
          ));
          break;
        case UserRole.patient:
          selectedUser(UserRoles(
            id: '4',
            name: 'Patient',
            role: UserRole.patient,
            phoneNumber: '',
          ));
          break;
      }

      isLoading(false);
      pendingPhoneNumber(null);
      pendingRole(null);
      return true;
    } else {
      isLoading(false);
      return false;
    }
  }

  void logout() {
    selectedUser(null);
    pendingPhoneNumber(null);
    pendingRole(null);
  }
}
