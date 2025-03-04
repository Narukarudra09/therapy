import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/patient_provider.dart';
import 'package:therapy/screens/patient_screen/new_phone_number.dart';
import 'package:therapy/screens/patient_screen/verify_otp.dart';

import '../../widgets/custom_button.dart';

class UpdatePhoneNumber extends StatefulWidget {
  const UpdatePhoneNumber({super.key});

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController.text = _auth.currentUser?.phoneNumber ?? '';
  }

  Future<void> _sendOTP() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a phone number')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final provider = Provider.of<PatientProvider>(context, listen: false);
      await provider.sendOTP(_phoneController.text);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOTP(
              newPhoneNumber: _phoneController.text,
              onVerificationComplete: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPhoneNumber(
                      verifiedPhoneNumber: _phoneController.text,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
        ),
        scrolledUnderElevation: 0,
        title: Text(
          'Update Phone Number',
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
                  'Phone Number',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Color(0xFF878DBA),
                  ),
                ),
                Text(
                  '*',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Color(0xFFFF2B2B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
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
            ),
            const SizedBox(height: 52),
            CustomButton(
              title: _isLoading ? "Sending OTP..." : "Send OTP",
              onTap: _sendOTP,
            ),
          ],
        ),
      ),
    );
  }
}
