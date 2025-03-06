class Therapist {
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? centerName;
  String? gender;
  bool? isActive;
  List<String>? kycDocuments;

  Therapist({
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.centerName,
    this.gender,
    this.isActive,
    this.kycDocuments,
  });

  factory Therapist.fromFirestore(Map<String, dynamic> json) {
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

  Map<String, dynamic> toMap() {
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
