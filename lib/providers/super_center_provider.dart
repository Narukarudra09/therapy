import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:therapy/models/center_owner.dart';
import 'package:therapy/models/holiday.dart';

import '../models/therapist.dart';

class SuperCenterProvider with ChangeNotifier {
  bool _isLoginAllowed = true;
  Map<String, Holiday> _holidays = {};
  final List<Map<String, dynamic>> _records = [];
  final List<Map<String, dynamic>> _announcements = [];
  final List<String> _selectedMediums = [];
  String? selectedRole;
  String? selectedCenter;
  String? selectedGender;
  bool isActive = true;
  List<PlatformFile> selectedFiles = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isLoginAllowed => _isLoginAllowed;

  Map<String, Holiday> get holidays => _holidays;

  List<Map<String, dynamic>> get records => _records;

  List<Map<String, dynamic>> get announcements => _announcements;

  List<String> get selectedMediums => _selectedMediums;

  CenterOwner get owner => _owner;

  Map<String, TimeOfDay> get openingTimes => _openingTimes;

  Map<String, TimeOfDay> get closingTimes => _closingTimes;
  final List<CenterOwner> _centerOwner = [];
  final List<Therapist> _therapists = [];

  List<Therapist> get therapists => _therapists;

  List<CenterOwner> get centerOwner => _centerOwner;

  // TextEditingControllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController feeController = TextEditingController();

  // Center owner data
  final CenterOwner _owner = CenterOwner(
    centerName: 'Gardens Galleria Par',
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
    id: '',
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

  void addTherapist(Therapist therapist) {
    if (!_therapists.any((t) => t.name == therapist.name)) {
      _therapists.add(therapist);
    }
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

  void updateData(Map<String, dynamic> data) {
    _holidays =
        Map<String, Holiday>.from(data['holidays'] as Map<String, Holiday>);
    notifyListeners();
  }

  void addOrUpdateHoliday(String day, Holiday holiday) {
    _holidays[day] = holiday;
    notifyListeners();
  }

  void setTime(String day, TimeOfDay time, bool isOpeningTime) {
    if (isOpeningTime) {
      _openingTimes[day] = time;
    } else {
      _closingTimes[day] = time;
    }
    notifyListeners();
  }

  void updateWorkingHour(Map<String, dynamic> data) {
    _holidays = Map<String, Holiday>.from(data['holidays'] ?? _holidays);
    notifyListeners();
  }

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

  void addAnnouncement(Map<String, dynamic> announcement) {
    _announcements.add(announcement);
    notifyListeners();
  }

  void toggleMedium(String medium) {
    if (_selectedMediums.contains(medium)) {
      _selectedMediums.remove(medium);
    } else {
      _selectedMediums.add(medium);
    }
    notifyListeners();
  }

  bool isMediumSelected(String medium) {
    return _selectedMediums.contains(medium);
  }

  void saveTherapyCenterData({
    required bool isActive,
    required bool isLoginAllowed,
    required String email,
    required String phone,
    required String about,
    required String location,
    required String fee,
  }) {
    this.isActive = isActive;
    this.isLoginAllowed = isLoginAllowed;
    emailController.text = email;
    phoneController.text = phone;
    aboutController.text = about;
    locationController.text = location;
    feeController.text = fee;
    notifyListeners();
  }

  void saveWorkingHours(Map<String, TimeOfDay> openingTimes,
      Map<String, TimeOfDay> closingTimes) {
    _openingTimes.addAll(openingTimes);
    _closingTimes.addAll(closingTimes);
    notifyListeners();
  }

  void saveHolidays(Map<String, Holiday> holidays) {
    _holidays.addAll(holidays);
    notifyListeners();
  }
}
