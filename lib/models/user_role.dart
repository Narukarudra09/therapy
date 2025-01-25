enum UserRole { superAdmin, centerOwner, therapist, patient }

class UserRoles {
  final String id;
  final String name;
  final UserRole role;

  UserRoles({required this.id, required this.name, required this.role});
}
