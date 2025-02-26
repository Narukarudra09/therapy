class Patient {
  String? id;
  String? name;
  String? phone;
  String? city;
  String? bloodGroup;
  List<String> allergies;
  List<Map<String, dynamic>> medicalRecords;
  List<Map<String, dynamic>> therapySessions;
  List<Map<String, dynamic>> payments;
  String? email;
  String? gender;
  String? dateOfBirth;

  Patient({
    this.id,
    this.name,
    this.phone,
    this.city,
    this.bloodGroup,
    required this.allergies,
    required this.medicalRecords,
    required this.therapySessions,
    required this.payments,
    this.email,
    this.gender,
    this.dateOfBirth,
  });

  factory Patient.fromFirestore(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      phone: json['phoneNumber'],
      city: json['city'],
      bloodGroup: json['bloodGroup'],
      allergies: json['allergies'],
      medicalRecords: json['medicalRecords'],
      therapySessions: json['therapySessions'],
      payments: json['payment'],
      email: json['email'],
      gender: json['gender'],
      dateOfBirth: json['dob'],
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
