import 'package:get/get.dart';

import '../models/medical_record.dart';
import '../models/patient.dart';
import '../models/payment.dart';
import '../models/therapy_session.dart';

class SuperPatientController extends GetxController {
  var patients = <Patient>[].obs;
  var selectedPatient = Rxn<Patient>();
  var isLoading = false.obs;
  var error = ''.obs;
  final RxList allergies = [].obs;

  void setLoading(bool loading) {
    isLoading(loading);
  }

  void setError(String? errorMessage) {
    error(errorMessage ?? '');
  }

  void selectPatient(String patientId) {
    selectedPatient(patients.firstWhere((patient) => patient.id == patientId));
  }

  Future<void> fetchPatients() async {
    setLoading(true);
    setError(null);

    try {
      patients.assignAll([
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
      ]);
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
      patients.add(patient);
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
      final index = patients.indexWhere((p) => p.id == patient.id);
      if (index != -1) {
        patients[index] = patient;
        if (selectedPatient.value?.id == patient.id) {
          selectedPatient(patient);
        }
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
      final patient = patients.firstWhere((p) => p.id == patientId);
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
      final patient = patients.firstWhere((p) => p.id == patientId);
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
      final patient = patients.firstWhere((p) => p.id == patientId);
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
