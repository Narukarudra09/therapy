import 'package:flutter/material.dart';

class PatientProvider extends ChangeNotifier {
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
}
