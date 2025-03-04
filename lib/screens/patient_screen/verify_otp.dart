import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/verify_otp.dart';

class VerifyOTP extends StatefulWidget {
  final String newPhoneNumber;
  final VoidCallback onVerificationComplete;

  const VerifyOTP({
    Key? key,
    required this.newPhoneNumber,
    required this.onVerificationComplete,
  }) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
        scrolledUnderElevation: 0,
        title: Text(
          'Verify Phone Number',
          style: GoogleFonts.inter(
            color: Color(0xFF171C22),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Enter OTP",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Color(0xFF878DBA),
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
            VerifyOtp(
              controller: _otpController,
            ),
            const SizedBox(height: 52),
            CustomButton(
              title: "Verify",
              onTap: _verifyOTP,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOTP() async {
    try {
      // ... existing verification code ...

      // After successful verification
      widget.onVerificationComplete();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
