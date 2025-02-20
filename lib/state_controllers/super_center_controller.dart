import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapy/models/center_owner.dart';
import 'package:therapy/models/holiday.dart';

class SuperCenterController extends GetxController {
  // Reactive variables
  final isActive = true.obs;
  final isLoginAllowed = true.obs;
  var holidays = <String, Holiday>{}.obs;
  var records = <Map<String, dynamic>>[].obs;
  var announcements = <Map<String, dynamic>>[].obs;
  var selectedMediums = <String>[].obs;

  // TextEditingControllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController feeController = TextEditingController();

  // Center owner data
  CenterOwner owner = CenterOwner(
    centerName: '',
    name: "Dr. Rudra",
    role: "Owner",
    phoneNumber: "7878404583",
    email: "narukarudra09@gmail.com",
    about:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    location: "Pandariya, kawardha(kabirdham), CHHATTISGARH",
    fees: "250",
    workingHours: {},
    holidays: [],
  );

  // Maps to store opening and closing times for each day
  final openingTimes = {
    'Monday': TimeOfDay(hour: 10, minute: 15),
    'Tuesday': TimeOfDay(hour: 10, minute: 15),
    'Wednesday': TimeOfDay(hour: 10, minute: 15),
    'Thursday': TimeOfDay(hour: 10, minute: 15),
    'Friday': TimeOfDay(hour: 10, minute: 15),
    'Saturday': TimeOfDay(hour: 10, minute: 15),
    'Sunday': TimeOfDay(hour: 10, minute: 15),
  }.obs;

  final closingTimes = {
    'Monday': TimeOfDay(hour: 23, minute: 0),
    'Tuesday': TimeOfDay(hour: 23, minute: 0),
    'Wednesday': TimeOfDay(hour: 23, minute: 0),
    'Thursday': TimeOfDay(hour: 23, minute: 0),
    'Friday': TimeOfDay(hour: 23, minute: 0),
    'Saturday': TimeOfDay(hour: 23, minute: 0),
    'Sunday': TimeOfDay(hour: 23, minute: 0),
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

  // Method to update data
  void updateData(Map<String, dynamic> data) {
    holidays.assignAll(data['holidays'] as Map<String, Holiday>);
  }

  // Method to add or update a holiday
  void addOrUpdateHoliday(String day, Holiday holiday) {
    holidays[day] = holiday;
  }

  // Method to set the time for a specific day
  void setTime(String day, TimeOfDay time, bool isOpeningTime) {
    if (isOpeningTime) {
      openingTimes[day] = time;
    } else {
      closingTimes[day] = time;
    }
  }

  // Method to update working hours
  void updateWorkingHour(Map<String, dynamic> data) {
    holidays.value = Map<String, Holiday>.from(data['holidays'] ?? holidays);
  }

  // Method to add a record
  void addRecord(Map<String, dynamic> record) {
    records.add(record);
  }

  void toggleHoliday(String day, bool isHoliday) {
    if (isHoliday) {
      holidays[day] = Holiday();
    } else {
      holidays.remove(day);
    }
  }

  // Method to add an announcement
  void addAnnouncement(Map<String, dynamic> announcement) {
    announcements.add(announcement);
  }

  // Method to toggle selected medium
  void toggleMedium(String medium) {
    if (selectedMediums.contains(medium)) {
      selectedMediums.remove(medium);
    } else {
      selectedMediums.add(medium);
    }
  }

  // Method to check if a medium is selected
  bool isMediumSelected(String medium) {
    return selectedMediums.contains(medium);
  }
}
