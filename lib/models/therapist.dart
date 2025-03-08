class Therapist {
  String? phoneNumber;
  String? name;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? city;
  String? imageUrl;
  String? role;
  String? centerName;
  bool? isActive;
  List<String>? kycDocuments;

  Therapist({
    this.phoneNumber,
    this.name,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.city,
    this.imageUrl,
    this.role,
    this.centerName,
    this.isActive,
    this.kycDocuments,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'city': city,
      'imageUrl': imageUrl,
      'type': 'therapist',
      'role': role,
      'centerName': centerName,
      'isActive': isActive,
      'kycDocuments': kycDocuments,
    };
  }

  static Therapist fromFirestore(Map<String, dynamic> data) {
    return Therapist(
      phoneNumber: data['phoneNumber']?.toString(),
      name: data['name']?.toString(),
      email: data['email']?.toString(),
      gender: data['gender']?.toString(),
      dateOfBirth: data['dateOfBirth']?.toString(),
      city: data['city']?.toString(),
      imageUrl: data['imageUrl']?.toString(),
      role: data['role']?.toString(),
      centerName: data['centerName']?.toString(),
      isActive: data['isActive'],
      kycDocuments: List<String>.from(data['kycDocuments'] ?? []),
    );
  }

  Therapist copyWith({
    String? phoneNumber,
    String? name,
    String? email,
    String? gender,
    String? dateOfBirth,
    String? city,
    String? imageUrl,
    String? role,
    String? centerName,
    bool? isActive,
    List<String>? kycDocuments,
  }) {
    return Therapist(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      city: city ?? this.city,
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
      centerName: centerName ?? this.centerName,
      isActive: isActive ?? this.isActive,
      kycDocuments: kycDocuments ?? this.kycDocuments,
    );
  }
}
