import 'package:flutter/material.dart';

class CenterOwner {
  final String centerName;
  final String name;
  final String role;
  final String phoneNumber;
  final String email;
  final String about;
  final String location;
  final String fees;
  final Map<String, Map<String, TimeOfDay>> workingHours;
  final List<String> holidays;

  CenterOwner({
    required this.centerName,
    required this.name,
    required this.role,
    required this.phoneNumber,
    required this.email,
    required this.about,
    required this.location,
    required this.fees,
    required this.workingHours,
    required this.holidays,
  });

  factory CenterOwner.fromJson(Map<String, dynamic> json) {
    return CenterOwner(
      centerName: json['CenterOwner'],
      name: json['name'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      about: json['about'],
      location: json['location'],
      fees: json['fees'],
      workingHours:
          (json['workingHours'] as Map<String, dynamic>).map((key, value) {
        return MapEntry(key, Map<String, TimeOfDay>.from(value));
      }),
      holidays: List<String>.from(json['holidays']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "centerName": centerName,
      'name': name,
      'role': role,
      'phoneNumber': phoneNumber,
      'email': email,
      'about': about,
      'location': location,
      'fees': fees,
      'workingHours': workingHours.map((key, value) {
        return MapEntry(key, value);
      }),
      'holidays': holidays,
    };
  }
}
