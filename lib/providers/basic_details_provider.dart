import 'package:flutter/material.dart';

class BasicDetailsProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  String? selectedDate;
  bool isLoading = true;

  void updateFormData({
    String? name,
    String? email,
    String? dateOfBirth,
    String? gender,
    bool? loading,
  }) {
    if (name != null) nameController.text = name;
    if (email != null) emailController.text = email;
    if (dateOfBirth != null) selectedDate = dateOfBirth;
    if (gender != null) genderController.text = gender;
    if (loading != null) isLoading = loading;

    notifyListeners();
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    genderController.clear();
    selectedDate = null;
    isLoading = true;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    super.dispose();
  }
}
