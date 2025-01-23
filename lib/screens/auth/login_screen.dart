import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_button.dart';
import 'package:therapy/widgets/login_textfield.dart';

import '../../widgets/login_dropmenu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              "Welcome",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 23, 28, 34),
              ),
            ),
            Text(
              "You’ve been missed",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 102, 114, 128),
              ),
            ),
            SizedBox(
              height: 46,
            ),
            Row(
              children: [
                Text(
                  "Login as",
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
            LoginDropMenu(),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  "Phone Number",
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
            LoginTextField(),
            SizedBox(
              height: 52,
            ),
            CustomButton(
              title: "Login",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
