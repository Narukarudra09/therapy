class SuperAdmin {
  final String id;
  final String name;
  final String phoneNumber;
  final String location;

  SuperAdmin({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.location,
  });

  factory SuperAdmin.fromFirestore(Map<String, dynamic> json) {
    return SuperAdmin(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      location: json['location'],
    );
  }
}
