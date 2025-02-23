class Therapist {
  String name;
  String email;
  String phoneNumber;
  String role;
  String centerName;
  String gender;
  bool isActive;
  List<String> kycDocuments;

  Therapist({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.centerName,
    required this.gender,
    required this.isActive,
    required this.kycDocuments,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) {
    return Therapist(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      centerName: json['centerName'],
      gender: json['gender'],
      isActive: json['isActive'],
      kycDocuments: List<String>.from(json['kycDocuments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'centerName': centerName,
      'gender': gender,
      'isActive': isActive,
      'kycDocuments': kycDocuments,
    };
  }
}
