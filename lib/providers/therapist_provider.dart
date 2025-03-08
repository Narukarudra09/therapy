import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:therapy/models/therapist.dart';

class TherapistProvider extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  Therapist? _therapist;
  File? _selectedImage;
  String? _profileImageUrl;
  bool _isLoading = false;

  List<Map<String, dynamic>> _todayRecords = [];
  List<Map<String, dynamic>> _searchResults = [];

  String? selectedPatientName;
  String? selectedPatientPhone;
  List<String> selectedTherapies = [];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Therapist? get therapist => _therapist;
  File? get selectedImage => _selectedImage;
  String? get profileImageUrl => _profileImageUrl;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get todayRecords => _todayRecords;
  List<Map<String, dynamic>> get searchResults => _searchResults;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setImage(File image) {
    _selectedImage = image;
    notifyListeners();
  }

  Future<void> initializeTherapist() async {
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
          Map<String, dynamic> data = {};
          // Carefully construct the data map with only the fields we need
          final docData = doc.data() ?? {};
          data = {
            'phoneNumber': phoneNumber,
            'name': docData['name'],
            'email': docData['email'],
            'gender': docData['gender'],
            'dateOfBirth': docData['dateOfBirth'],
            'city': docData['city'],
            'imageUrl': docData['imageUrl'],
            'type': 'therapist',
          };

          _therapist = Therapist.fromFirestore(data);
          _profileImageUrl = _therapist?.imageUrl;
        } else {
          // Create a new therapist document with minimal data
          Map<String, dynamic> initialData = {
            'phoneNumber': phoneNumber,
            'name': null,
            'email': null,
            'gender': null,
            'dateOfBirth': null,
            'city': null,
            'imageUrl': null,
            'type': 'therapist',
            'createdAt': FieldValue.serverTimestamp(),
          };

          await firestore
              .collection('Users')
              .doc(phoneNumber)
              .collection('data')
              .doc('info')
              .set(initialData);

          _therapist = Therapist.fromFirestore(initialData);
        }
        notifyListeners();
      }
    } catch (e) {
      print('Error initializing therapist: $e');
      throw Exception('Failed to initialize therapist data: $e');
    }
  }

  Future<void> loadTherapistData(String phone) async {
    try {
      setLoading(true);
      final doc = await firestore.collection('therapists').doc(phone).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        _therapist = Therapist.fromFirestore(data);
        _profileImageUrl = _therapist?.imageUrl;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading therapist data: $e');
      throw e;
    } finally {
      setLoading(false);
    }
  }

  Future<void> saveTherapistData(Therapist therapist) async {
    try {
      setLoading(true);

      if (_selectedImage != null) {
        final ref =
            storage.ref().child('therapist_profiles/${therapist.phoneNumber}');
        await ref.putFile(_selectedImage!);
        _profileImageUrl = await ref.getDownloadURL();
        therapist.imageUrl = _profileImageUrl;
      }

      await firestore
          .collection('Users')
          .doc(therapist.phoneNumber)
          .collection('data')
          .doc('info')
          .set(therapist.toMap());

      _therapist = therapist;
      notifyListeners();
    } catch (e) {
      print('Error saving therapist data: $e');
      throw e;
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateTherapistProfile(Map<String, dynamic> data) async {
    try {
      setLoading(true);
      if (_therapist != null) {
        await firestore
            .collection('Users')
            .doc(_therapist!.phoneNumber)
            .collection('data')
            .doc('info')
            .update(data);
        await loadTherapistData(_therapist!.phoneNumber!);
      }
    } catch (e) {
      print('Error updating therapist profile: $e');
      throw e;
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadTodayRecords() async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      // Get today's start and end
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(Duration(days: 1));

      final records = await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('records')
          .where('timestamp', isGreaterThanOrEqualTo: today)
          .where('timestamp', isLessThan: tomorrow)
          .orderBy('timestamp', descending: true)
          .get();

      _todayRecords = records.docs.map((doc) => doc.data()).toList();
      notifyListeners();
    } catch (e) {
      print('Error getting therapist records: $e');
      throw Exception('Failed to get therapist records: $e');
    }
  }

  Future<void> addRecord(Map<String, dynamic> record) async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) throw Exception('No authenticated user found');

      // Add record to Firestore
      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('records')
          .add(record);

      // Reload today's records
      await loadTodayRecords();
    } catch (e) {
      print('Error adding record: $e');
      throw Exception('Failed to add record: $e');
    }
  }

  Future<void> saveBasicDetails(
    String name,
    String email,
    String? dateOfBirth,
    String? gender,
  ) async {
    try {
      final phoneNumber = auth.currentUser?.phoneNumber;
      if (phoneNumber == null) {
        throw Exception('No authenticated user found');
      }

      final updatedData = {
        'name': name,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'type': 'therapist',
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await firestore
          .collection('Users')
          .doc(phoneNumber)
          .collection('data')
          .doc('info')
          .set(updatedData, SetOptions(merge: true));

      _therapist = Therapist(
        phoneNumber: phoneNumber,
        name: name,
        email: email,
        dateOfBirth: dateOfBirth,
        gender: gender,
        imageUrl: _therapist?.imageUrl,
        city: _therapist?.city,
      );

      notifyListeners();
    } catch (e) {
      print('Error saving therapist details: $e');
      throw Exception('Failed to save therapist details: $e');
    }
  }

  Future<bool> checkExistingDetails() async {
    try {
      initializeTherapist();

      if (_therapist != null) {
        return _therapist!.name != null &&
            _therapist!.email != null &&
            _therapist!.dateOfBirth != null &&
            _therapist!.gender != null;
      }
      return false;
    } catch (e) {
      print('Error checking existing details: $e');
      return false;
    }
  }

  Future<void> searchPatients(String query) async {
    try {
      if (query.length < 2) {
        _searchResults = [];
        notifyListeners();
        return;
      }

      final querySnapshot = await firestore
          .collection('Users')
          .where('type', isEqualTo: 'patient')
          .get();

      // Store results without notifying immediately
      _searchResults = querySnapshot.docs
          .where((doc) => (doc.data()['name'] ?? '')
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((doc) => {
                'name': doc.data()['name'] ?? '',
                'phone': doc.id,
              })
          .toList();

      // Notify after all processing is done
      notifyListeners();
    } catch (e) {
      print('Error searching patients: $e');
      _searchResults = [];
      notifyListeners();
    }
  }

  void updateSelectedPatient(String name, String phone) {
    selectedPatientName = name;
    selectedPatientPhone = phone;
    _searchResults = []; // Clear search results
    notifyListeners();
  }

  void updateSelectedTherapies(List<String> therapies) {
    selectedTherapies = List.from(therapies);
    notifyListeners();
  }

  void removeTherapy(String therapy) {
    selectedTherapies.remove(therapy);
    notifyListeners();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void updateSelectedTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }
}
