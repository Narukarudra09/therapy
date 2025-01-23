import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_button.dart';
import 'package:therapy/widgets/verify_otp.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  width: 6,
                ),
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
            SizedBox(
              height: 16,
            ),
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
                  "+91-7878404583",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 27, 25, 75),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "Change",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 65, 184, 119),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 43,
            ),
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
            SizedBox(
              height: 8,
            ),
            VerifyOtp(),
            SizedBox(
              height: 52,
            ),
            CustomButton(
              title: "Verity",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
