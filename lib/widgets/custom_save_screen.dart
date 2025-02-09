import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:therapy/screens/main_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
        title: Text(
          'Update Phone Number',
          style: GoogleFonts.inter(
            color: Color(0xFF171C22),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                "https://lottie.host/edc03ec3-9dd7-4aa3-b5eb-b72cca73ddd8/jWdUCVg9ng.json",
                width: 250,
                height: 250,
                repeat: false),
            const SizedBox(height: 40),
            const Text(
              'Phone Number Changed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'successfully',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            TextButton.icon(
              onPressed: () {
                Get.off(MainScreen(patientName: ""));
              },
              icon: const Icon(
                size: 30,
                Icons.home_filled,
                color: Color(0xFF4CD080),
              ),
              label: const Text(
                'Back to Home',
                style: TextStyle(
                  color: Color(0xFF4CD080),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
