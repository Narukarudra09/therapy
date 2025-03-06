import 'package:flutter/material.dart';

class CenterOwner {
  final String? id;
  final String? centerName;
  final String? name;
  final String? role;
  final String? phoneNumber;
  final String? email;
  final String? about;
  final String? location;
  final String? fees;
  final Map<String, Map<String, TimeOfDay>>? workingHours;
  final List<String>? holidays;

  CenterOwner({
    this.centerName,
    this.name,
    this.role,
    this.phoneNumber,
    this.email,
    this.about,
    this.location,
    this.fees,
    this.workingHours,
    this.holidays,
    this.id,
  });

  factory CenterOwner.fromFirestore(Map<String, dynamic> json) {
    return CenterOwner(
      id: json["id"],
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

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "centerName": centerName,
      'name': name,
      'role': role,
      'phoneNumber': phoneNumber,
      'email': email,
      'about': about,
      'location': location,
      'fees': fees,
      'workingHours': workingHours!.map((key, value) {
        return MapEntry(key, value);
      }),
      'holidays': holidays,
    };
  }

  CenterOwner copyWith({
    String? centerName,
    String? name,
    String? role,
    String? phoneNumber,
    String? email,
    String? about,
    String? location,
    String? fees,
    Map<String, Map<String, TimeOfDay>>? workingHours,
    List<String>? holidays,
  }) {
    return CenterOwner(
      centerName: centerName ?? this.centerName,
      name: name ?? this.name,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
