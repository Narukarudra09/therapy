class Patient {
  String id;
  String name;
  String phone;
  String city;
  String bloodGroup;
  List<String> allergies;
  List<Map<String, dynamic>> medicalRecords;
  List<Map<String, dynamic>> therapySessions;
  List<Map<String, dynamic>> payments;
  String email;
  String gender;
  String? dateOfBirth;

  Patient({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.bloodGroup,
    required this.allergies,
    required this.medicalRecords,
    required this.therapySessions,
    required this.payments,
    required this.email,
    required this.gender,
    this.dateOfBirth,
  });

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      allergies: List<String>.from(map['allergies'] ?? []),
      medicalRecords:
          List<Map<String, dynamic>>.from(map['medicalRecords'] ?? []),
      therapySessions:
          List<Map<String, dynamic>>.from(map['therapySessions'] ?? []),
      payments: List<Map<String, dynamic>>.from(map['payments'] ?? []),
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'city': city,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'medicalRecords': medicalRecords,
      'therapySessions': therapySessions,
      'payments': payments,
      'email': email,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }

  Patient copyWith({
    String? id,
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
  }) {
    return Patient(
      id: id ?? this.id,
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
    );
  }
}
