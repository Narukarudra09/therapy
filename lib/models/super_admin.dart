class SuperAdmin {
  final String? name;
  final String? phoneNumber;
  final String? location;

  SuperAdmin({
    this.name,
    this.phoneNumber,
    this.location,
  });

  factory SuperAdmin.fromFirestore(Map<String, dynamic> json) {
    return SuperAdmin(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'location': location,
    };
  }
}
