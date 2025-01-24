import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyOtp extends StatelessWidget {
  final TextEditingController controller;

  const VerifyOtp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        style: GoogleFonts.inter(
          color: Color(0xFF2E2C34),
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: 50,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(6)],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.solid,
              strokeAlign: 1,
              color: Color.fromARGB(255, 232, 233, 241),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.solid,
              strokeAlign: 1,
              color: Color.fromARGB(255, 232, 233, 241),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.solid,
              strokeAlign: 1,
              color: Color.fromARGB(255, 232, 233, 241),
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "please enter your otp";
          }
          return null;
        },
      ),
    );
  }
}
