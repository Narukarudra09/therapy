import 'package:flutter/material.dart';

import '../models/medical_record.dart';
import '../models/patient.dart';
import '../models/payment.dart';
import '../models/therapy_session.dart';

class SuperPatientProvider extends ChangeNotifier {
  List<Patient> _patients = [];
  Patient? _selectedPatient;
  bool _isLoading = false;
  String? _error;

// Getters
  List<Patient> get patients => _patients;

  Patient? get selectedPatient => _selectedPatient;

  bool get isLoading => _isLoading;

  String? get error => _error;

// Methods
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void selectPatient(String patientId) {
    _selectedPatient =
        _patients.firstWhere((patient) => patient.id == patientId);
    notifyListeners();
  }

  Future<void> fetchPatients() async {
    setLoading(true);
    setError(null);

    try {
      _patients = [
        Patient(
          id: '1',
          name: 'Rudrapratap Singh Naruka',
          email: 'narukarudra2@gmail.com',
          phone: '1234567890',
          city: 'Bhilwara',
          gender: 'Male',
          bloodGroup: 'A+',
          allergies: ['Cheese', 'Milk'],
          medicalRecords: [
            MedicalRecord(
              id: '1',
              title: 'allergic khasi',
              date: '12-05-2023',
              fileUrl: 'assets/X-ray.png',
            ),
          ],
        ),
        // Add more dummy patients
      ];
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> addPatient(Patient patient) async {
    setLoading(true);
    setError(null);

    try {
      _patients.add(patient);
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> updatePatient(Patient patient) async {
    setLoading(true);
    setError(null);

    try {
      final index = _patients.indexWhere((p) => p.id == patient.id);
      if (index != -1) {
        _patients[index] = patient;
        if (_selectedPatient?.id == patient.id) {
          _selectedPatient = patient;
        }
        notifyListeners();
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> addAllergy(String patientId, String allergy) async {
    setLoading(true);
    setError(null);

    try {
      final patient = _patients.firstWhere((p) => p.id == patientId);
      final updatedPatient = patient.copyWith(
        allergies: [...patient.allergies, allergy],
      );
      await updatePatient(updatedPatient);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> addTherapySession(
      String patientId, TherapySession session) async {
    setLoading(true);
    setError(null);

    try {
      final patient = _patients.firstWhere((p) => p.id == patientId);
      final updatedPatient = patient.copyWith(
        therapySessions: [...patient.therapySessions, session],
      );
      await updatePatient(updatedPatient);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> addPayment(String patientId, Payment payment) async {
    setLoading(true);
    setError(null);

    try {
      final patient = _patients.firstWhere((p) => p.id == patientId);
      final updatedPatient = patient.copyWith(
        payments: [...patient.payments, payment],
      );
      await updatePatient(updatedPatient);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
