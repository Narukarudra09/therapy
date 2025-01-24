enum UserRole { superAdmin, centerOwner, therapist, patient }

class UserProfile {
  final String id;
  final String name;
  final UserRole role;

  UserProfile({required this.id, required this.name, required this.role});
}
