import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/patient.dart';

class PatientProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _records = [];
  Patient? _patient;

  Patient? get patient => _patient;

  List<Map<String, dynamic>> get records => _records;

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

  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setImage(File? image) {
    _selectedImage = image;
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

      if (_selectedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${patient.phone}.jpg');
        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        patient = patient.copyWith(profileImageUrl: imageUrl);
      }

      await firestore
          .collection('Users')
          .doc(patient.phone)
          .collection('data')
          .doc('info')
          .set({
        ...patient.toMap(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

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
}
