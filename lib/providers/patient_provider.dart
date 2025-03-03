import 'package:flutter/material.dart';

class PatientProvider with ChangeNotifier {
  List<Map<String, dynamic>> _records = [];

  List<Map<String, dynamic>> get records => _records;

  void setRecords(List<Map<String, dynamic>> records) {
    _records = records;
    notifyListeners();
  }

  void addRecord(Map<String, dynamic> record) {
    _records.add(record);
    notifyListeners();
  }

  void clearRecords() {
    _records.clear();
    notifyListeners();
  }

  int get completedDays => _records.length;

  int get totalDays {
    if (_records.length < 7) {
      return 7;
    } else {
      return (_records.length ~/ 7 + 1) * 7;
    }
  }
}
