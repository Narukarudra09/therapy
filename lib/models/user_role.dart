enum UserRole { superAdmin, centerOwner, therapist, patient }

class UserRoles {
  final String id;
  final String phoneNumber;
  final UserRole role;

  UserRoles({
    required this.id,
    required this.phoneNumber,
    required this.role,
    required String name,
  });
}
