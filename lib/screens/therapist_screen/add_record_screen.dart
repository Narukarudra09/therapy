import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _givenByController = TextEditingController();
  String _selectedTherapy = 'Select';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<String> therapies = [
    'Select', // Add a default option
    'Physical Therapy',
    'Occupational Therapy',
    'Speech Therapy',
    'Cognitive Therapy',
    'Other'
  ];

  void _saveRecord() {
    // Implement save logic here
    print('Patient Name: ${_patientNameController.text}');
    print('Therapy Type: $_selectedTherapy');
    print('Date: ${_selectedDate.toLocal()}');
    print('Time: ${_selectedTime.format(context)}');
    print('Given By: ${_givenByController.text}');
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Record"),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 23, 28, 34),
        ),
        actions: [
          InkWell(
            onTap: _saveRecord,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 65, 184, 119),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      "Save",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Full Name',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _patientNameController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 46, 44, 52),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the patient's name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Type Of Therapy',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedTherapy,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                iconEnabledColor: const Color(0xFF171C22),
                iconDisabledColor: const Color(0xFF171C22),
                dropdownColor: const Color.fromARGB(255, 243, 243, 253),
                decoration: InputDecoration(
                  hintText: "Select",
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2E2C34),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                ),
                items: therapies.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTherapy = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != _selectedDate) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 232, 233, 241)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_selectedDate.toLocal()}".split(' ')[0],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 46, 44, 52),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Color(0xFF171C22),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );
                        if (picked != null && picked != _selectedTime) {
                          setState(() {
                            _selectedTime = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 232, 233, 241)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedTime.format(context),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 46, 44, 52),
                              ),
                            ),
                            Icon(
                              Icons.access_time,
                              size: 18,
                              color: Color(0xFF171C22),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Given By',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _givenByController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 46, 44, 52),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
