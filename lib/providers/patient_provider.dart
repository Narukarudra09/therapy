import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/patient.dart';

class PatientProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  String? _verificationId;
  List<Map<String, dynamic>> _records = [];
  Patient? _patient;

  Patient? get patient => _patient;
  String? get verificationId => _verificationId;

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

      // Get current phone number if patient phone is null
      final phoneNumber = patient.phone ?? auth.currentUser?.phoneNumber;
      if (phoneNumber == null || phoneNumber.isEmpty) {
        throw Exception('Phone number is required');
      }

      if (_selectedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/$phoneNumber.jpg');
        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        patient = patient.copyWith(profileImageUrl: imageUrl);
      }

      // Update the patient object with the phone number
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
}
