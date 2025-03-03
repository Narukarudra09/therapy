class SuperAdmin {
  final String name;
  final String phoneNumber;
  final String location;

  SuperAdmin({
    required this.name,
    required this.phoneNumber,
    required this.location,
  });

  factory SuperAdmin.fromFirestore(Map<String, dynamic> json) {
    return SuperAdmin(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      location: json['location'],
    );
  }
}
