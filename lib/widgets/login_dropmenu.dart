import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginDropMenu extends StatefulWidget {
  const LoginDropMenu({super.key});

  @override
  State<LoginDropMenu> createState() => _LoginDropMenuState();
}

class _LoginDropMenuState extends State<LoginDropMenu> {
  @override
  Widget build(BuildContext context) {
    String selectedRole = 'patient';
    return DropdownButtonFormField<String>(
      value: selectedRole,
      borderRadius: BorderRadius.circular(8),
      iconEnabledColor: Color.fromARGB(255, 23, 28, 34),
      iconDisabledColor: Color.fromARGB(255, 23, 28, 34),
      dropdownColor: const Color.fromARGB(255, 243, 243, 253),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 232, 233, 241),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 232, 233, 241),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 232, 233, 241),
          ),
        ),
        hintText: 'Select',
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(255, 102, 114, 128),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 243, 243, 253),
      ),
      items: [
        DropdownMenuItem(
            value: 'Super Admin',
            child: Text(
              'Super Admin',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 73, 13, 140),
              ),
            )),
        DropdownMenuItem(
            value: 'Center Owner',
            child: Text(
              'Center Owner',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 73, 13, 140),
              ),
            )),
        DropdownMenuItem(
            value: 'Therapist',
            child: Text(
              'Therapist',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 73, 13, 140),
              ),
            )),
        DropdownMenuItem(
            value: 'Patient',
            child: Text(
              'Patient',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 73, 13, 140),
              ),
            )),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedRole = newValue!;
        });
      },
    );
  }
}
