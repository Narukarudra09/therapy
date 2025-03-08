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

  Therapist? get therapist => _therapist;
  File? get selectedImage => _selectedImage;
  String? get profileImageUrl => _profileImageUrl;
  bool get isLoading => _isLoading;

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
          final data = doc.data();
          if (data != null) {
            _therapist = Therapist.fromFirestore({
              ...data,
              'phoneNumber': phoneNumber,
            });
            _profileImageUrl = _therapist?.imageUrl;
          }
        } else {
          _therapist = Therapist(phoneNumber: phoneNumber);
          await firestore
              .collection('Users')
              .doc(phoneNumber)
              .collection('data')
              .doc('info')
              .set({
            ..._therapist!.toMap(),
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
          .collection('therapists')
          .doc(therapist.phoneNumber)
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
            .collection('therapists')
            .doc(_therapist!.phoneNumber)
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
}
