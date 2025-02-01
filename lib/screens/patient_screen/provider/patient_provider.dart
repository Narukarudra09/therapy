// patient_provider.dart
import 'package:flutter/material.dart';

class PatientProvider extends ChangeNotifier {
  String _patientName = '';
  String _phoneNumber = '';
  String _email = '';
  String _dateOfBirth = '';
  bool _hasCompletedProfile = false;

  // Getters
  String get patientName => _patientName;

  String get phoneNumber => _phoneNumber;

  String get email => _email;

  String get dateOfBirth => _dateOfBirth;

  bool get hasCompletedProfile => _hasCompletedProfile;

  // Initialize patient data with phone number after successful login
  void initializePatient(String phone) {
    _phoneNumber = phone;
    notifyListeners();
  }

  // Update patient profile
  void updateProfile({
    required String name,
    String? phone, // Made optional since we might already have it
    required String email,
    required String dob,
  }) {
    _patientName = name;
    _phoneNumber = phone ?? _phoneNumber; // Keep existing phone if not provided
    _email = email;
    _dateOfBirth = dob;
    _hasCompletedProfile = true;
    notifyListeners();
  }

  // Reset patient data
  void reset() {
    _patientName = '';
    _phoneNumber = '';
    _email = '';
    _dateOfBirth = '';
    _hasCompletedProfile = false;
    notifyListeners();
  }

  void updatePhoneNumber(String text) {}
}
