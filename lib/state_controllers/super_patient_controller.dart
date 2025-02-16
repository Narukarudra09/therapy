import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/medical_record.dart';
import '../models/patient.dart';
import '../models/payment.dart';
import '../models/therapy_session.dart';

class SuperPatientController extends GetxController {
  var patients = <Patient>[].obs;
  var selectedPatient = Rxn<Patient>();
  var isLoading = false.obs;
  var error = ''.obs;

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

  // Method to save basic details
  void saveBasicDetails(String name, String email, String? dateOfBirth) {
    if (selectedPatient.value != null) {
      final updatedPatient = selectedPatient.value!.copyWith(
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

  var allergies = <String>[
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
  ].obs;

  var selectedAllergies = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize selectedAllergies with the same length as allergies
    selectedAllergies.value = List.generate(allergies.length, (_) => false);
  }

  void addAllergy(String newAllergy) {
    allergies.add(newAllergy);
    selectedAllergies.add(true);
  }

  void toggleSelection(int index) {
    selectedAllergies[index] = !selectedAllergies[index];
  }

  List<String> getSelectedAllergies() {
    return selectedAllergies
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => allergies[entry.key])
        .toList();
  }

  var bloodGroup = 'A+'.obs;

  var medicalRecords = <Map<String, dynamic>>[].obs;
  var prescriptions = <Map<String, dynamic>>[].obs;

  void updateBloodGroup(String newBloodGroup) {
    bloodGroup.value = newBloodGroup;
  }

  void deleteAllergy(String allergy) {
    allergies.remove(allergy);
  }

  Future<void> pickImage(ImageSource source, bool isPrescription) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      String imageName = image.name;
      String imageTime =
          DateFormat('dd-MM-yyyy • hh:mm a').format(DateTime.now());

      if (isPrescription) {
        prescriptions.add(
            {'title': imageName, 'date': imageTime, 'imagePath': image.path});
      } else {
        medicalRecords.add(
            {'title': imageName, 'date': imageTime, 'imagePath': image.path});
      }
    }
  }

  void deleteRecord(Map<String, dynamic> record) {
    medicalRecords.remove(record);
  }

  void deletePrescription(Map<String, dynamic> prescription) {
    prescriptions.remove(prescription);
  }
}
