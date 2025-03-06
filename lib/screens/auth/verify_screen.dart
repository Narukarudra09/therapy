import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/screens/auth/basic_patient_detail.dart';
import 'package:therapy/screens/auth/login_screen.dart';
import 'package:therapy/screens/main_screen.dart';
import 'package:therapy/widgets/custom_button.dart';
import 'package:therapy/widgets/verify_otp.dart';

import '../../providers/auth_provider.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  final String userType; // Change to String

  const VerifyScreen({
    super.key,
    required this.phoneNumber,
    required this.userType,
  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _otpController = TextEditingController();

  void _verifyOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      bool isVerified =
          await authProvider.verifyOtp(_otpController.text, widget.userType);

      if (isVerified) {
        if (widget.userType == 'Patient' || widget.userType == 'Therapist') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BasicPersonalDetails(
                      userType: widget.userType,
                    )),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid OTP. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
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
        child: SingleChildScrollView(
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
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
      ),
    );
  }
}
