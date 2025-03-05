import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/medical_record.dart';
import '../models/prescription.dart';

class PatientProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  String? _verificationId;
  List<Map<String, dynamic>> _records = [];
  Patient? _patient;
  File? _selectedImage;
  String? _profileImageUrl;
  List<MedicalRecord> _medicalRecords = [];
  List<Prescription> _prescriptions = [];
  final Set<String> _selectedAllergies = {};
  final TextEditingController _newAllergyController = TextEditingController();
  final List<String> _predefinedAllergies = [
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
  static const String _profileImageKey = 'profile_image_url';

  Patient? get patient => _patient;
  String? get verificationId => _verificationId;
  File? get selectedImage => _selectedImage;
  String? get profileImageUrl => _profileImageUrl;

  List<Map<String, dynamic>> get records => _records;
  List<MedicalRecord> get medicalRecords => _medicalRecords;
  List<Prescription> get prescriptions => _prescriptions;

  Set<String> get selectedAllergies => _selectedAllergies;
  List<String> get predefinedAllergies => _predefinedAllergies;

  TextEditingController get newAllergyController => _newAllergyController;

  void setRecords(List<Map<String, dynamic>> records) {
    _records = records;
    notifyListeners();
  }

  void addRecord(Map<String, dynamic> record) {
    _records.add(record);
    notifyListeners();
  }

  void clearRecords() {
    _records.clear();
    notifyListeners();
  }

  int get completedDays => _records.length;

  int get totalDays {
    if (_records.length < 7) {
      return 7;
    } else {
      return (_records.length ~/ 7 + 1) * 7;
    }
  }

  Future<void> initializePatient() async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber != null) {
        final doc = await firestore
            .collection('Users')
            .doc(phoneNumber)
            .collection('data')
            .doc('info')
            .get();

        if (doc.exists) {
          final data = doc.data();
          if (data != null) {
            _patient = Patient.fromFirestore({
              ...data,
              'phoneNumber': phoneNumber,
            });
            _profileImageUrl = _patient?.profileImageUrl;
          }
        } else {
          _patient = Patient(phone: phoneNumber);
          await firestore
              .collection('Users')
              .doc(phoneNumber)
              .collection('data')
              .doc('info')
              .set({
            ..._patient!.toMap(),
            'phoneNumber': phoneNumber,
          });
        }
        notifyListeners();
      }
    } catch (e) {
      print('Error initializing patient: $e');
      throw Exception('Failed to initialize patient data');
    }
  }

  Future<void> savePatientData(Patient patient) async {
    try {
      _patient = patient;
      final phoneNumber = patient.phone ?? auth.currentUser?.phoneNumber;
      if (phoneNumber == null || phoneNumber.isEmpty) {
        throw Exception('Phone number is required');
      }

      if (_selectedImage != null) {
        try {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('user_profiles')
              .child(phoneNumber)
              .child('profile.jpg');

          await storageRef.putFile(_selectedImage!);
          final imageUrl = await storageRef.getDownloadURL();
          patient = patient.copyWith(profileImageUrl: imageUrl);
          _profileImageUrl = imageUrl;
        } catch (e) {
          print('Error uploading image: $e');
          throw Exception('Failed to upload profile image: $e');
        }
      }

      patient = patient.copyWith(phone: phoneNumber);

      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .set({
        ...patient.toMap(),
        'phoneNumber': phoneNumber,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await saveToPrefs();
      notifyListeners();
    } catch (e) {
      print('Error saving patient data: $e');
      throw Exception('Failed to save patient data: $e');
    }
  }

  Future<void> saveBasicDetails(
      String name, String email, String? dateOfBirth, String? gender) async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) {
        throw Exception('No authenticated user found');
      }

      _patient = Patient(
        phone: phoneNumber,
        name: name,
        email: email,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .update({
        'name': name,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      notifyListeners();
    } catch (e) {
      print('Error saving patient details: $e');
      throw Exception('Failed to save patient details: $e');
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          _verificationId = null;
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException e) {
          _verificationId = null;
          notifyListeners();
          throw Exception('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
      throw Exception('Failed to send OTP: $e');
    }
  }

  Future<void> verifyCurrentPhoneNumber(String otp) async {
    try {
      if (_verificationId == null) {
        throw Exception('No verification ID found');
      }

      final currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      // Verify OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential);
      _verificationId = null;
      notifyListeners();
    } catch (e) {
      print('Error verifying OTP: $e');
      throw Exception('Failed to verify OTP: $e');
    }
  }

  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) throw Exception('No authenticated user found');

      final oldPhoneNumber = currentUser.phoneNumber;
      if (oldPhoneNumber == null) {
        throw Exception('Current phone number not found');
      }

      // Get current patient data
      final doc = await firestore
          .collection('Users')
          .doc(oldPhoneNumber)
          .collection('data')
          .doc('info')
          .get();

      if (doc.exists) {
        // Create new document with new phone number
        await firestore
            .collection('Users')
            .doc(newPhoneNumber)
            .collection('data')
            .doc('info')
            .set(doc.data()!);

        // Delete old document
        await firestore
            .collection('Users')
            .doc(oldPhoneNumber)
            .collection('data')
            .doc('info')
            .delete();

        // Update local patient object
        if (_patient != null) {
          _patient = _patient!.copyWith(phone: newPhoneNumber);
          notifyListeners();
        }
      }
    } catch (e) {
      throw Exception('Failed to update phone number: $e');
    }
  }

  void setImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }

  void setProfileImageUrl(String? url) {
    _profileImageUrl = url;
    notifyListeners();
  }

  Future<void> saveToPrefs() async {
    if (_patient != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('phone', _patient!.phone ?? '');
      await prefs.setString('name', _patient!.name ?? '');
      await prefs.setString('profileImageUrl', _profileImageUrl ?? '');
      await prefs.setString('city', _patient!.city ?? '');
    }
  }

  Future<bool> loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final phone = prefs.getString('phone');
      final name = prefs.getString('name');
      final profileImageUrl = prefs.getString('profileImageUrl');
      final city = prefs.getString('city');

      if (phone != null) {
        _patient = Patient(
          phone: phone,
          name: name,
          profileImageUrl: profileImageUrl,
          city: city,
        );
        _profileImageUrl = profileImageUrl;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error loading preferences: $e');
      return false;
    }
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> logout() async {
    await clearPrefs();
    _patient = null;
    _profileImageUrl = null;
    notifyListeners();
    await auth.signOut();
  }

  Future<void> addMedicalRecord({
    required String title,
    required File imageFile,
    bool isPrescription = false,
  }) async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String id =
          '${isPrescription ? "prescription" : "record"}_$timestamp';

      // Create storage reference
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('medical_records')
          .child(phoneNumber)
          .child(isPrescription ? 'prescriptions' : 'records')
          .child(id);

      // Set metadata for caching
      final metadata = SettableMetadata(
        cacheControl: 'public, max-age=31536000', // Cache for 1 year
        contentType: 'image/jpeg',
      );

      // Upload file with metadata
      await storageRef.putFile(imageFile, metadata);
      final fileUrl = await storageRef.getDownloadURL();

      // Create record object
      final record = isPrescription
          ? Prescription(
              id: id,
              title: title,
              date: DateTime.now().toString(),
              fileUrl: fileUrl,
            )
          : MedicalRecord(
              id: id,
              title: title,
              date: DateTime.now().toString(),
              fileUrl: fileUrl,
            );

      // Save to Firestore
      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .update({
        isPrescription ? 'prescriptions' : 'medicalRecords':
            FieldValue.arrayUnion([
          isPrescription
              ? (record as Prescription).toMap()
              : (record as MedicalRecord).toMap()
        ]),
      });

      // Update local state
      if (isPrescription) {
        _prescriptions.add(record as Prescription);
      } else {
        _medicalRecords.add(record as MedicalRecord);
      }
      notifyListeners();
    } catch (e) {
      print('Error adding record: $e');
      throw Exception('Failed to add record: $e');
    }
  }

  Future<void> deleteRecord(String id, bool isPrescription) async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      // Delete from Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('medical_records')
          .child(phoneNumber)
          .child(isPrescription ? 'prescriptions' : 'records')
          .child(id);
      await storageRef.delete();

      // Delete from Firestore
      final record = isPrescription
          ? _prescriptions.firstWhere((p) => p.id == id)
          : _medicalRecords.firstWhere((m) => m.id == id);

      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .update({
        isPrescription ? 'prescriptions' : 'medicalRecords':
            FieldValue.arrayRemove([
          isPrescription
              ? (record as Prescription).toMap()
              : (record as MedicalRecord).toMap()
        ]),
      });

      // Update local state
      if (isPrescription) {
        _prescriptions.removeWhere((p) => p.id == id);
      } else {
        _medicalRecords.removeWhere((m) => m.id == id);
      }
      notifyListeners();
    } catch (e) {
      print('Error deleting record: $e');
      throw Exception('Failed to delete record: $e');
    }
  }

  Future<void> loadRecords() async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      final doc = await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          _medicalRecords = (data['medicalRecords'] as List<dynamic>?)
                  ?.map((m) => MedicalRecord.fromMap(m))
                  .toList() ??
              [];
          _prescriptions = (data['prescriptions'] as List<dynamic>?)
                  ?.map((p) => Prescription.fromMap(p))
                  .toList() ??
              [];
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error loading records: $e');
      throw Exception('Failed to load records: $e');
    }
  }

  Future<void> saveMedicalHistory() async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .update({
        'bloodGroup': patient?.bloodGroup,
        'allergies': patient?.allergies,
        'medicalRecords': _medicalRecords.map((r) => r.toMap()).toList(),
        'prescriptions': _prescriptions.map((p) => p.toMap()).toList(),
      });
    } catch (e) {
      print('Error saving medical history: $e');
      throw Exception('Failed to save medical history: $e');
    }
  }

  Future<void> updateBloodGroup(String newBloodGroup) async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      // Update local state
      if (patient != null) {
        _patient = patient!.copyWith(bloodGroup: newBloodGroup);
        notifyListeners();
      }

      // Update Firestore
      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .update({
        'bloodGroup': newBloodGroup,
      });
    } catch (e) {
      print('Error updating blood group: $e');
      throw Exception('Failed to update blood group: $e');
    }
  }

  Future<void> removeAllergy(String allergy) async {
    try {
      if (patient?.allergies != null) {
        patient?.allergies?.remove(allergy);
        notifyListeners();
        await saveMedicalHistory();
      }
    } catch (e) {
      print('Error removing allergy: $e');
      throw Exception('Failed to remove allergy: $e');
    }
  }

  Future<void> addAllergies(List<String> newAllergies) async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      // Get current allergies or initialize empty list
      List<String> currentAllergies = patient?.allergies ?? [];

      // Add new allergies (avoid duplicates)
      currentAllergies.addAll(
          newAllergies.where((allergy) => !currentAllergies.contains(allergy)));

      // Update local state
      _patient = patient?.copyWith(allergies: currentAllergies);
      notifyListeners();

      // Update Firestore
      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .update({
        'allergies': currentAllergies,
      });
    } catch (e) {
      print('Error adding allergies: $e');
      throw Exception('Failed to add allergies: $e');
    }
  }

  Future<void> loadPatientData() async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      final docSnapshot = await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        _patient = Patient.fromMap(data);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading patient data: $e');
      throw Exception('Failed to load patient data: $e');
    }
  }

  void toggleAllergy(String allergy) {
    if (_selectedAllergies.contains(allergy)) {
      _selectedAllergies.remove(allergy);
    } else {
      _selectedAllergies.add(allergy);
    }
    notifyListeners();
  }

  void removeSelectedAllergy(String allergy) {
    _selectedAllergies.remove(allergy);
    notifyListeners();
  }

  Future<void> saveSelectedAllergies() async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      // Get current allergies or initialize empty list
      List<String> currentAllergies = patient?.allergies ?? [];

      // Add new allergies (avoid duplicates)
      currentAllergies.addAll(_selectedAllergies
          .where((allergy) => !currentAllergies.contains(allergy)));

      // Update local state
      _patient = patient?.copyWith(allergies: currentAllergies);

      // Update Firestore
      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .update({
        'allergies': currentAllergies,
      });

      // Clear selected allergies
      _selectedAllergies.clear();
      notifyListeners();
    } catch (e) {
      print('Error saving allergies: $e');
      throw Exception('Failed to save allergies: $e');
    }
  }

  void clearSelectedAllergies() {
    _selectedAllergies.clear();
    notifyListeners();
  }

  void addCustomAllergy(String allergy) {
    if (allergy.trim().isNotEmpty) {
      _selectedAllergies.add(allergy.trim());
      _newAllergyController.clear();
      notifyListeners();
    }
  }

  void loadExistingAllergies() {
    if (patient?.allergies != null) {
      _selectedAllergies.clear();
      _selectedAllergies.addAll(patient!.allergies!);
      notifyListeners();
    }
  }

  Future<void> addNewAllergy(String allergy) async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      if (allergy.trim().isNotEmpty) {
        // Add to predefined list if it's not already there
        if (!_predefinedAllergies.contains(allergy.trim())) {
          _predefinedAllergies.add(allergy.trim());
        }
        // Select the new allergy
        _selectedAllergies.add(allergy.trim());
        notifyListeners();
      }
    } catch (e) {
      print('Error adding new allergy: $e');
      throw Exception('Failed to add new allergy: $e');
    }
  }

  Future<void> saveProfileImage(String imageUrl) async {
    _profileImageUrl = imageUrl;

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, imageUrl);

    notifyListeners();
  }

  Future<void> loadProfileImageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _profileImageUrl = prefs.getString(_profileImageKey);
    notifyListeners();
  }

  Future<void> clearProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profileImageKey);
    _profileImageUrl = null;
    notifyListeners();
  }

  @override
  void dispose() {
    clearSelectedAllergies();
    _newAllergyController.dispose();
    super.dispose();
  }
}
