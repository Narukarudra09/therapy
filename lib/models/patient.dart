import 'package:therapy/models/payment.dart';
import 'package:therapy/models/prescription.dart';
import 'package:therapy/models/therapy_session.dart';

import 'medical_record.dart';

class Patient {
  final String id;
  final String name;
  String email;
  final String phone;
  final String gender;
  final String city;
  final String bloodGroup;
  final List<String> allergies;
  final List<MedicalRecord> medicalRecords;
  final List<Prescription> prescriptions;
  final List<TherapySession> therapySessions;
  final List<Payment> payments;
  String? dateOfBirth;

  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.city,
    required this.bloodGroup,
    this.allergies = const [],
    this.medicalRecords = const [],
    this.prescriptions = const [],
    this.therapySessions = const [],
    this.payments = const [],
    this.dateOfBirth,
  });

  Patient copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? city,
    String? bloodGroup,
    List<String>? allergies,
    List<MedicalRecord>? medicalRecords,
    List<Prescription>? prescriptions,
    List<TherapySession>? therapySessions,
    List<Payment>? payments,
    String? dateOfBirth,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergies: allergies ?? this.allergies,
      medicalRecords: medicalRecords ?? this.medicalRecords,
      prescriptions: prescriptions ?? this.prescriptions,
      therapySessions: therapySessions ?? this.therapySessions,
      payments: payments ?? this.payments,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
