import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/screens/main_screen.dart';
import 'package:therapy/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String _selectedRole = 'Super Admin';
final controller = TextEditingController();
final formKey = GlobalKey<FormState>();

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
            DropdownButtonFormField<String>(
              value: _selectedRole,
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
            ),
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
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 102, 114, 128),
                ),
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
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter your number";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 52,
            ),
            CustomButton(
              title: "Login",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      role: _selectedRole,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
