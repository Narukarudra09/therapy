import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/medical_record.dart';
import '../models/patient.dart';
import '../models/payment.dart';
import '../models/therapy_session.dart';

class SuperPatientProvider extends ChangeNotifier {
  List<Patient> _patients = [];
  Patient? _selectedPatient;
  bool _isLoading = false;
  String _error = '';

  List<Patient> get patients => _patients;

  Patient? get selectedPatient => _selectedPatient;

  bool get isLoading => _isLoading;

  String get error => _error;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? errorMessage) {
    _error = errorMessage ?? '';
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

  void saveBasicDetails(String name, String email, String? dateOfBirth) {
    if (_selectedPatient != null) {
      final updatedPatient = _selectedPatient!.copyWith(
        name: name,
        email: email,
        dateOfBirth: dateOfBirth,
      );
      updatePatient(updatedPatient);
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

  final List<String> _allergies = [
    'Cheese',
    'Curd',
    'Egg',
    'Garlic',
    'Gluten',
    'Lemon',
    'Meat',
    'Milk',
    'Nuts',
    'Oats',
    'Other Fruits',
    'Peanut',
    'Peppers',
    'Preserved Foods',
    'Shellfish/Fish',
    'Soya',
  ];
  List<bool> _selectedAllergies = [];

  List<String> get allergies => _allergies;

  List<bool> get selectedAllergies => _selectedAllergies;

  SuperPatientProvider() {
    _selectedAllergies = List.generate(_allergies.length, (_) => false);
  }

  void addAllergy(String newAllergy) {
    _allergies.add(newAllergy);
    _selectedAllergies.add(true);
    notifyListeners();
  }

  void toggleSelection(int index) {
    _selectedAllergies[index] = !_selectedAllergies[index];
    notifyListeners();
  }

  List<String> getSelectedAllergies() {
    return _selectedAllergies
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => _allergies[entry.key])
        .toList();
  }

  String _bloodGroup = 'A+';

  String get bloodGroup => _bloodGroup;

  List<Map<String, dynamic>> _medicalRecords = [];
  List<Map<String, dynamic>> _prescriptions = [];

  List<Map<String, dynamic>> get medicalRecords => _medicalRecords;

  List<Map<String, dynamic>> get prescriptions => _prescriptions;

  void updateBloodGroup(String newBloodGroup) {
    _bloodGroup = newBloodGroup;
    notifyListeners();
  }

  void deleteAllergy(String allergy) {
    int index = _allergies.indexOf(allergy);
    if (index != -1) {
      _allergies.removeAt(index);
      _selectedAllergies.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> pickImage(ImageSource source, bool isPrescription) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      String imageName = image.name;
      String imageTime =
          DateFormat('dd-MM-yyyy • hh:mm a').format(DateTime.now());

      if (isPrescription) {
        _prescriptions.add(
            {'title': imageName, 'date': imageTime, 'imagePath': image.path});
      } else {
        _medicalRecords.add(
            {'title': imageName, 'date': imageTime, 'imagePath': image.path});
      }
      notifyListeners();
    }
  }

  void deleteRecord(Map<String, dynamic> record) {
    _medicalRecords.remove(record);
    notifyListeners();
  }

  void deletePrescription(Map<String, dynamic> prescription) {
    _prescriptions.remove(prescription);
    notifyListeners();
  }
}
