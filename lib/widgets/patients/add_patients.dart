import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/patient.dart';
import '../../providers/super_patient_provider.dart';
import 'add_allergies.dart';

class AddPatients extends StatefulWidget {
  const AddPatients({super.key});

  @override
  State<AddPatients> createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  final _formKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  String city = 'Bhilwara';

  List<String> selectedAllergies = [];
  List<String> gender = ['Male', 'Female', 'Others'];

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _fullNameController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _savePatient() {
    if (_formKey.currentState!.validate()) {
      final newPatient = Patient(
        id: DateTime.now().toString(),
        name: _fullNameController.text,
        phone: _mobileNumberController.text,
        city: city,
        bloodGroup: 'A+',
        // Default blood group, can be updated later
        allergies: selectedAllergies,
        medicalRecords: [],
        therapySessions: [],
        payments: [],
        email: _emailController.text,
        gender: _genderController.text,
      );

      final provider =
          Provider.of<SuperPatientProvider>(context, listen: false);
      provider.addPatient(newPatient);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SuperPatientProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Patients"),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 23, 28, 34),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
        actions: [
          InkWell(
            onTap: _savePatient,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 65, 184, 119),
              ),
              child: Center(
                child: Text(
                  "Save",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Basic Profile",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 23, 28, 34),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      "Mobile Number",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 135, 141, 186),
                      ),
                    ),
                    Text(
                      "*",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 255, 43, 43),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2E2C34),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  "Full Name",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E2C34),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the full name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  "Email",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E2C34),
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
                      return "Please enter the email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  "Gender",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _genderController.text.isNotEmpty
                      ? _genderController.text
                      : null,
                  icon: Icon(Icons.keyboard_arrow_down),
                  borderRadius: BorderRadius.circular(8),
                  iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                  iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                  dropdownColor: const Color.fromARGB(255, 243, 243, 253),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                  ),
                  items: gender
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: FittedBox(
                              child: Text(
                                role,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2E2C34),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _genderController.text = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a gender";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  "City",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  borderRadius: BorderRadius.circular(8),
                  iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                  iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                  dropdownColor: const Color.fromARGB(255, 243, 243, 253),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                  ),
                  items: ['Bhilwara']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: FittedBox(
                              child: Text(
                                role,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2E2C34),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      city = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a city";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Medical Profile",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 23, 28, 34),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Blood Group",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  borderRadius: BorderRadius.circular(8),
                  iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                  iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                  dropdownColor: const Color.fromARGB(255, 243, 243, 253),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 232, 233, 241)),
                    ),
                  ),
                  items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: FittedBox(
                              child: Text(
                                role,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2E2C34),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      provider.updateBloodGroup(newValue!);
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a blood group";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 250, 250, 250),
                    border: Border.all(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Allergies",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 46, 44, 52),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAllergies()),
                              ).then((value) {
                                if (value != null && value is List<String>) {
                                  setState(() {
                                    selectedAllergies = value;
                                  });
                                }
                              });
                            },
                            child: Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 73, 13, 140),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 4,
                        children: selectedAllergies
                            .map((allergy) => Chip(
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  label: Text(allergy),
                                  labelStyle: GoogleFonts.inter(
                                    color: Color.fromARGB(255, 46, 44, 52),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  deleteIcon: const Icon(Icons.close),
                                  onDeleted: () {
                                    provider.deleteAllergy(allergy);
                                  },
                                  backgroundColor:
                                      Color.fromARGB(255, 233, 233, 233),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _buildSection(
                  'Medical Records',
                  Column(
                    children: provider.medicalRecords
                        .map((record) => _buildRecordItem(
                              record['title'],
                              record['date'],
                              record['imagePath'],
                              onDelete: () => provider.deleteRecord(record),
                            ))
                        .toList(),
                  ),
                  onTap: () => provider.pickImage(ImageSource.gallery, false),
                ),
                const SizedBox(height: 8),
                _buildSection(
                  'Past Prescriptions',
                  Column(
                    children: provider.prescriptions
                        .map((prescription) => _buildRecordItem(
                              prescription['title'],
                              prescription['date'],
                              prescription['imagePath'],
                              onDelete: () =>
                                  provider.deletePrescription(prescription),
                            ))
                        .toList(),
                  ),
                  onTap: () => provider.pickImage(ImageSource.gallery, true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSection(String title, Widget content, {void Function()? onTap}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      border: Border.all(
        color: Color(0xFFE8E9F1),
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.add,
                  color: const Color(0xFF6750A4),
                ),
              ),
            ],
          ),
        ),
        content,
      ],
    ),
  );
}

Widget _buildRecordItem(String title, String date, String imagePath,
    {void Function()? onDelete}) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8),
        image: imagePath != null
            ? DecorationImage(
                image: FileImage(File(imagePath)),
                fit: BoxFit.cover,
              )
            : null,
      ),
    ),
    title: Text(title),
    titleTextStyle: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF2E2C34)),
    subtitle: Text(date),
    subtitleTextStyle:
        GoogleFonts.inter(fontSize: 12, color: Color(0xFF939EAA)),
    trailing: IconButton(
      icon: Icon(Icons.close),
      onPressed: onDelete,
    ),
  );
}
