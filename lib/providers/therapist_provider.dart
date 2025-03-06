import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TherapistProvider extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future<void> saveTherapistBasicDetails(
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
      print('Error saving therapist details: $e');
      throw Exception('Failed to save therapist details: $e');
    }
  }
}
