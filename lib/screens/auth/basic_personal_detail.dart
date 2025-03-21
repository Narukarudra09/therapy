import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/patient_provider.dart';
import 'package:therapy/providers/basic_details_provider.dart';
import 'package:therapy/providers/therapist_provider.dart';

import '../../widgets/custom_button.dart';
import '../main_screen.dart';

class BasicPersonalDetails extends StatefulWidget {
  const BasicPersonalDetails({
    super.key,
  });

  @override
  State<BasicPersonalDetails> createState() => _BasicPersonalDetailsState();
}

class _BasicPersonalDetailsState extends State<BasicPersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  final List<String> gender = ['Male', 'Female', 'Others'];
  bool isPatient = true;

  @override
  void initState() {
    super.initState();
    _checkUserTypeAndDetails();
  }

  Future<void> _checkUserTypeAndDetails() async {
    try {
      final patientProvider =
          Provider.of<PatientProvider>(context, listen: false);
      final therapistProvider =
          Provider.of<TherapistProvider>(context, listen: false);
      final basicDetailsProvider =
          Provider.of<BasicDetailsProvider>(context, listen: false);

      // Check if user exists in patients collection
      await patientProvider.initializePatient();
      if (patientProvider.patient != null) {
        isPatient = true;
        final patient = patientProvider.patient!;
        if (patient.name != null &&
            patient.email != null &&
            patient.dateOfBirth != null &&
            patient.gender != null) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          }
          return;
        }
        basicDetailsProvider.updateFormData(
          name: patient.name,
          email: patient.email,
          dateOfBirth: patient.dateOfBirth,
          gender: patient.gender,
          loading: false,
        );
        return;
      }

      // Check if user exists in therapists collection
      await therapistProvider.initializeTherapist();
      if (therapistProvider.therapist != null) {
        isPatient = false;
        final therapist = therapistProvider.therapist!;
        if (therapist.name != null &&
            therapist.email != null &&
            therapist.dateOfBirth != null &&
            therapist.gender != null) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          }
          return;
        }
        basicDetailsProvider.updateFormData(
          name: therapist.name,
          email: therapist.email,
          dateOfBirth: therapist.dateOfBirth,
          gender: therapist.gender,
          loading: false,
        );
        return;
      }

      basicDetailsProvider.updateFormData(loading: false);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading user data: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveDetails() async {
    if (_formKey.currentState!.validate()) {
      try {
        final patientProvider =
            Provider.of<PatientProvider>(context, listen: false);
        final therapistProvider =
            Provider.of<TherapistProvider>(context, listen: false);
        final basicDetailsProvider =
            Provider.of<BasicDetailsProvider>(context, listen: false);

        if (isPatient) {
          // Save patient details
          await patientProvider.saveBasicDetails(
            basicDetailsProvider.nameController.text,
            basicDetailsProvider.emailController.text,
            basicDetailsProvider.selectedDate,
            basicDetailsProvider.genderController.text,
          );
        } else {
          // Save therapist details
          await therapistProvider.saveBasicDetails(
            basicDetailsProvider.nameController.text,
            basicDetailsProvider.emailController.text,
            basicDetailsProvider.selectedDate,
            basicDetailsProvider.genderController.text,
          );
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save details: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final basicDetailsProvider =
        Provider.of<BasicDetailsProvider>(context, listen: false);

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
              dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.green.shade400;
                }
                return null;
              }),
              todayBackgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
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
      basicDetailsProvider.updateFormData(
        dateOfBirth: picked.toLocal().toString().split(' ')[0],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasicDetailsProvider>(
      builder: (context, basicDetailsProvider, child) {
        if (basicDetailsProvider.isLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF40B777),
              ),
            ),
          );
        }

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
                    _buildTextField(
                      label: "Your Name",
                      controller: basicDetailsProvider.nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: "Email Address",
                      controller: basicDetailsProvider.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildGenderDropdown(basicDetailsProvider),
                    const SizedBox(height: 16),
                    _buildDatePicker(basicDetailsProvider),
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
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 135, 141, 186),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
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
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildGenderDropdown(BasicDetailsProvider basicDetailsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          value: basicDetailsProvider.genderController.text.isNotEmpty
              ? basicDetailsProvider.genderController.text
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
            basicDetailsProvider.updateFormData(
              gender: newValue,
            );
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select a gender";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker(BasicDetailsProvider basicDetailsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date of Birth",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 135, 141, 186),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: IgnorePointer(
            child: TextFormField(
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF2E2C34),
              ),
              controller: TextEditingController(
                text: basicDetailsProvider.selectedDate,
              ),
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
      ],
    );
  }
}
