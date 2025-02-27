import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/super_patient_provider.dart';
import '../../widgets/custom_button.dart';
import '../main_screen.dart';

class BasicPersonalDetails extends StatefulWidget {
  const BasicPersonalDetails({super.key});

  @override
  State<BasicPersonalDetails> createState() => _BasicPersonalDetailsState();
}

class _BasicPersonalDetailsState extends State<BasicPersonalDetails> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  String? _selectedDate;
  final _formKey = GlobalKey<FormState>();
  List<String> gender = ['Male', 'Female', 'Others'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<SuperPatientProvider>(context, listen: false);
      if (provider.selectedPatient != null) {
        final patient = provider.selectedPatient!;
        _nameController.text = patient.name!;
        _emailController.text = patient.email!;
        _selectedDate = patient.dateOfBirth;
        _genderController.text = patient.gender ?? '';
      }
    });
  }

  void _saveDetails() {
    if (_formKey.currentState!.validate()) {
      final provider =
          Provider.of<SuperPatientProvider>(context, listen: false);
      provider.saveBasicDetails(
        _nameController.text,
        _emailController.text,
        _selectedDate,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade400,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green.shade400,
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              headerBackgroundColor: Colors.white,
              headerForegroundColor: Colors.black,
              headerHeadlineStyle: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
              ),
              weekdayStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
              dayStyle: const TextStyle(
                fontSize: 16,
              ),
              todayBorder: BorderSide(
                color: Colors.green.shade400,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.green.shade400;
                }
                return null;
              }),
              todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.green.shade400;
                }
                return Colors.transparent;
              }),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
        titleTextStyle: GoogleFonts.inter(
          color: Color.fromARGB(255, 8, 10, 19),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
            child: Text(
              "Skip",
              style: GoogleFonts.inter(
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF868686),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF868686),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add few more details",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 23, 28, 34),
                  ),
                ),
                const SizedBox(height: 21),
                Text(
                  "Your Name",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
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
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Email Address",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF2E2C34),
                  ),
                  controller: _emailController,
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
                      return "Please enter your address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                SizedBox(height: 16),
                Text(
                  "Date of Birth",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                SizedBox(height: 8),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: TextFormField(
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF2E2C34),
                      ),
                      controller: TextEditingController(text: _selectedDate),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month),
                        suffixIconColor: Color(0xFF292D32),
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
                          return "Please enter your date of birth";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 52),
                CustomButton(
                  title: "Save",
                  onTap: _saveDetails,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
