import 'package:flutter/material.dart';
import 'package:therapy/models/center_owner.dart';
import 'package:therapy/models/holiday.dart';

class SuperCenterProvider with ChangeNotifier {
  // Reactive variables
  bool _isActive = true;
  bool _isLoginAllowed = true;
  Map<String, Holiday> _holidays = {};
  List<Map<String, dynamic>> _records = [];
  List<Map<String, dynamic>> _announcements = [];
  List<String> _selectedMediums = [];

  // TextEditingControllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController feeController = TextEditingController();

  // Center owner data
  CenterOwner _owner = CenterOwner(
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
  final Map<String, TimeOfDay> _openingTimes = {
    'Monday': TimeOfDay(hour: 10, minute: 15),
    'Tuesday': TimeOfDay(hour: 10, minute: 15),
    'Wednesday': TimeOfDay(hour: 10, minute: 15),
    'Thursday': TimeOfDay(hour: 10, minute: 15),
    'Friday': TimeOfDay(hour: 10, minute: 15),
    'Saturday': TimeOfDay(hour: 10, minute: 15),
    'Sunday': TimeOfDay(hour: 10, minute: 15),
  };

  final Map<String, TimeOfDay> _closingTimes = {
    'Monday': TimeOfDay(hour: 23, minute: 0),
    'Tuesday': TimeOfDay(hour: 23, minute: 0),
    'Wednesday': TimeOfDay(hour: 23, minute: 0),
    'Thursday': TimeOfDay(hour: 23, minute: 0),
    'Friday': TimeOfDay(hour: 23, minute: 0),
    'Saturday': TimeOfDay(hour: 23, minute: 0),
    'Sunday': TimeOfDay(hour: 23, minute: 0),
  };

  // Getters
  bool get isActive => _isActive;

  bool get isLoginAllowed => _isLoginAllowed;

  Map<String, Holiday> get holidays => _holidays;

  List<Map<String, dynamic>> get records => _records;

  List<Map<String, dynamic>> get announcements => _announcements;

  List<String> get selectedMediums => _selectedMediums;

  CenterOwner get owner => _owner;

  Map<String, TimeOfDay> get openingTimes => _openingTimes;

  Map<String, TimeOfDay> get closingTimes => _closingTimes;

  // Setters
  set isActive(bool value) {
    _isActive = value;
    notifyListeners();
  }

  set isLoginAllowed(bool value) {
    _isLoginAllowed = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    locationController.dispose();
    feeController.dispose();
    super.dispose();
  }

  // Method to update data
  void updateData(Map<String, dynamic> data) {
    _holidays =
        Map<String, Holiday>.from(data['holidays'] as Map<String, Holiday>);
    notifyListeners();
  }

  // Method to add or update a holiday
  void addOrUpdateHoliday(String day, Holiday holiday) {
    _holidays[day] = holiday;
    notifyListeners();
  }

  // Method to set the time for a specific day
  void setTime(String day, TimeOfDay time, bool isOpeningTime) {
    if (isOpeningTime) {
      _openingTimes[day] = time;
    } else {
      _closingTimes[day] = time;
    }
    notifyListeners();
  }

  // Method to update working hours
  void updateWorkingHour(Map<String, dynamic> data) {
    _holidays = Map<String, Holiday>.from(data['holidays'] ?? _holidays);
    notifyListeners();
  }

  // Method to add a record
  void addRecord(Map<String, dynamic> record) {
    _records.add(record);
    notifyListeners();
  }

  void toggleHoliday(String day, bool isHoliday) {
    if (isHoliday) {
      _holidays[day] = Holiday();
    } else {
      _holidays.remove(day);
    }
    notifyListeners();
  }

  // Method to add an announcement
  void addAnnouncement(Map<String, dynamic> announcement) {
    _announcements.add(announcement);
    notifyListeners();
  }

  // Method to toggle selected medium
  void toggleMedium(String medium) {
    if (_selectedMediums.contains(medium)) {
      _selectedMediums.remove(medium);
    } else {
      _selectedMediums.add(medium);
    }
    notifyListeners();
  }

  // Method to check if a medium is selected
  bool isMediumSelected(String medium) {
    return _selectedMediums.contains(medium);
  }
}
