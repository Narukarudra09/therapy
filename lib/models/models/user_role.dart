import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String phoneNumber;
  final String userType;

  UserModel({required this.phoneNumber, required this.userType});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      phoneNumber: doc['phoneNumber'],
      userType: doc['userType'],
    );
  }
}
