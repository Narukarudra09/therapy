import 'package:flutter/material.dart';

class SuperPatientProvider extends ChangeNotifier {
  String _city = 'bhilwara';
  String _bloodGroup = 'A+';
  final List<String> _allergies = [];

  String get city => _city;

  String get bloodGroup => _bloodGroup;

  List<String> get allergies => _allergies;

  void setCity(String newCity) {
    _city = newCity;
    notifyListeners();
  }

  void setBloodGroup(String newBloodGroup) {
    _bloodGroup = newBloodGroup;
    notifyListeners();
  }

  void addAllergy(String allergy) {
    _allergies.add(allergy);
    notifyListeners();
  }

  void removeAllergy(String allergy) {
    _allergies.remove(allergy);
    notifyListeners();
  }
}
