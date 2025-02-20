import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapy/models/center_owner.dart';

import '../models/holiday.dart';

class SuperCenterController extends GetxController {
  final isActive = true.obs;
  final isLoginAllowed = true.obs;
  var holidays = <String, Holiday>{}.obs;
  var records = <Map<String, dynamic>>[].obs;
  var announcements = <Map<String, dynamic>>[].obs;
  var selectedMediums = <String>[].obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController feeController = TextEditingController();

  CenterOwner owner = CenterOwner(
      name: "Dr.Rudra",
      role: "Owner",
      phoneNumber: "7878404583",
      email: "narukarudra09@gmail.com",
      about:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      location: "Pandariya, kawardha(kabirdham), CHHATTISGARH",
      fees: "250",
      workingHours: {},
      holidays: []);

  void updateData(Map<String, dynamic> data) {
    holidays.assignAll(data['holidays'] as Map<String, Holiday>);
  }

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
    emailController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    locationController.dispose();
    feeController.dispose();
    super.onClose();
  }

  void toggleHoliday(String day, bool isHoliday) {
    if (isHoliday) {
      holidays[day] = Holiday();
    } else {
      holidays.remove(day);
    }
  }

  void setTime(String day, TimeOfDay time, bool isOpeningTime) {
    if (isOpeningTime) {
      openingTimes[day] = time;
    } else {
      closingTimes[day] = time;
    }
  }

  void updateWorkingHour(Map<String, dynamic> data) {
    holidays.value = Map<String, Holiday>.from(data['holidays'] ?? holidays);
  }

  void addRecord(Map<String, dynamic> record) {
    records.add(record);
  }

  void addAnnouncement(Map<String, dynamic> announcement) {
    announcements.add(announcement);
  }

  void toggleMedium(String medium) {
    if (selectedMediums.contains(medium)) {
      selectedMediums.remove(medium);
    } else {
      selectedMediums.add(medium);
    }
  }

  bool isMediumSelected(String medium) {
    return selectedMediums.contains(medium);
  }
}
