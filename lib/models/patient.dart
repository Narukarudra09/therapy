class Patient {
  String? name;
  String? phone;
  String? city;
  String? bloodGroup;
  List<String>? allergies;
  List<Map<String, dynamic>>? medicalRecords;
  List<Map<String, dynamic>>? therapySessions;
  List<Map<String, dynamic>>? payments;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? profileImageUrl;

  Patient({
    this.name,
    this.phone,
    this.city,
    this.bloodGroup,
    this.allergies,
    this.medicalRecords,
    this.therapySessions,
    this.payments,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.profileImageUrl,
  });

  factory Patient.fromFirestore(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      phone: json['phoneNumber'] ?? json['phone'],
      email: json['email'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      profileImageUrl: json['profileImageUrl'],
      city: json['city'],
      bloodGroup: json['bloodGroup'],
      allergies: json['allergies']?.cast<String>(),
      medicalRecords: json['medicalRecords']?.cast<Map<String, dynamic>>(),
      therapySessions: json['therapySessions']?.cast<Map<String, dynamic>>(),
      payments: json['payments']?.cast<Map<String, dynamic>>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phone,
      'email': email,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'profileImageUrl': profileImageUrl,
      'city': city,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'medicalRecords': medicalRecords,
      'therapySessions': therapySessions,
      'payments': payments,
    };
  }

  Patient copyWith({
    String? name,
    String? phone,
    String? city,
    String? bloodGroup,
    List<String>? allergies,
    List<Map<String, dynamic>>? medicalRecords,
    List<Map<String, dynamic>>? therapySessions,
    List<Map<String, dynamic>>? payments,
    String? email,
    String? gender,
    String? dateOfBirth,
    String? profileImageUrl,
  }) {
    return Patient(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergies: allergies ?? this.allergies,
      medicalRecords: medicalRecords ?? this.medicalRecords,
      therapySessions: therapySessions ?? this.therapySessions,
      payments: payments ?? this.payments,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
