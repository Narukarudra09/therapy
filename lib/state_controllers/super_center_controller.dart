import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuperCenterController extends GetxController {
  final isActive = true.obs;
  final isLoginAllowed = true.obs;

  // Use TextEditingController for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController feeController = TextEditingController();

  // Working Hours Data
  final holidays = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': true,
    'Sunday': true,
  }.obs;

  final openingTimes = {
    'Monday': TimeOfDay(hour: 00, minute: 0),
    'Tuesday': TimeOfDay(hour: 00, minute: 0),
    'Wednesday': TimeOfDay(hour: 00, minute: 0),
    'Thursday': TimeOfDay(hour: 00, minute: 0),
    'Friday': TimeOfDay(hour: 00, minute: 0),
    'Saturday': TimeOfDay(hour: 00, minute: 0),
    'Sunday': TimeOfDay(hour: 00, minute: 0),
  }.obs;

  final closingTimes = {
    'Monday': TimeOfDay(hour: 22, minute: 0),
    'Tuesday': TimeOfDay(hour: 22, minute: 0),
    'Wednesday': TimeOfDay(hour: 22, minute: 0),
    'Thursday': TimeOfDay(hour: 22, minute: 0),
    'Friday': TimeOfDay(hour: 22, minute: 0),
    'Saturday': TimeOfDay(hour: 22, minute: 0),
    'Sunday': TimeOfDay(hour: 22, minute: 0),
  }.obs;

  @override
  void onClose() {
    // Dispose of controllers
    emailController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    locationController.dispose();
    feeController.dispose();
    super.onClose();
  }

  void setInitialData(Map<String, dynamic> data) {
    isActive.value = data['isActive'] ?? true;
    isLoginAllowed.value = data['isLoginAllowed'] ?? true;
    emailController.text = data['email'] ?? '';
    phoneController.text = data['phone'] ?? '';
    aboutController.text = data['about'] ?? '';
    locationController.text = data['location'] ?? 'Bhilwara';
    feeController.text = data['fee'] ?? '';
    holidays.value = Map<String, bool>.from(data['holidays'] ?? {});
    openingTimes.value =
        Map<String, TimeOfDay>.from(data['openingTimes'] ?? {});
    closingTimes.value =
        Map<String, TimeOfDay>.from(data['closingTimes'] ?? {});
  }

  void updateData(Map<String, dynamic> data) {
    isActive.value = data['isActive'] ?? isActive.value;
    isLoginAllowed.value = data['isLoginAllowed'] ?? isLoginAllowed.value;
    emailController.text = data['email'] ?? emailController.text;
    phoneController.text = data['phone'] ?? phoneController.text;
    aboutController.text = data['about'] ?? aboutController.text;
    locationController.text = data['location'] ?? locationController.text;
    feeController.text = data['fee'] ?? feeController.text;
    holidays.value = Map<String, bool>.from(data['holidays'] ?? holidays);
    openingTimes.value =
        Map<String, TimeOfDay>.from(data['openingTimes'] ?? openingTimes);
    closingTimes.value =
        Map<String, TimeOfDay>.from(data['closingTimes'] ?? closingTimes);
  }

  void toggleHoliday(String day, bool isHoliday) {
    holidays[day] = isHoliday;
  }

  void setTime(String day, TimeOfDay time, bool isOpeningTime) {
    if (isOpeningTime) {
      openingTimes[day] = time;
    } else {
      closingTimes[day] = time;
    }
  }
}
