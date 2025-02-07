import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/screens/auth/basic_patient_detail.dart';
import 'package:therapy/screens/auth/login_screen.dart';
import 'package:therapy/screens/main_screen.dart';
import 'package:therapy/widgets/custom_button.dart';
import 'package:therapy/widgets/verify_otp.dart';

import '../../models/user_role.dart';
import '../../state_controllers/auth_controller.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  final UserRole selectedRole;

  const VerifyScreen(
      {super.key, required this.phoneNumber, required this.selectedRole});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _otpController = TextEditingController();

  void _verifyOtp() async {
    final authController = Get.find<AuthController>();

    try {
      bool isVerified = await authController.verifyOtp(
          phoneNumber: widget.phoneNumber,
          otp: _otpController.text,
          role: widget.selectedRole);

      if (isVerified) {
        if (widget.selectedRole == UserRole.patient ||
            widget.selectedRole == UserRole.therapist) {
          Get.off(() => BasicPersonalDetails());
        } else {
          Get.off(() => MainScreen(patientName: ''));
        }
      } else {
        Get.snackbar('Error', 'Invalid OTP',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Verification failed: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/logoG.svg"),
                const SizedBox(width: 6),
                Text(
                  "Therapy",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 6, 57, 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "OTP Verification",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 23, 28, 34),
              ),
            ),
            Row(
              children: [
                Text(
                  widget.phoneNumber,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 27, 25, 75),
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    Get.off(() => LoginScreen());
                  },
                  child: Text(
                    "Change",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 65, 184, 119),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 43),
            Row(
              children: [
                Text(
                  "ENTER OTP",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                Text(
                  "*",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 43, 43),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            VerifyOtp(controller: _otpController),
            const SizedBox(height: 52),
            CustomButton(
              title: "Verify",
              onTap: _verifyOtp,
            )
          ],
        ),
      ),
    );
  }
}
