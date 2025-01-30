import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/screens/auth/verify_screen.dart';
import 'package:therapy/widgets/custom_button.dart';

import '../../models/user_role.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectedRole = 'Super Admin';
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  UserRole _mapStringToUserRole(String role) {
    switch (role) {
      case 'Super Admin':
        return UserRole.superAdmin;
      case 'Center Owner':
        return UserRole.centerOwner;
      case 'Therapist':
        return UserRole.therapist;
      case 'Patient':
        return UserRole.patient;
      default:
        return UserRole.superAdmin;
    }
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      UserRole selectedRole = _mapStringToUserRole(_selectedRole);

      bool success = await authProvider.login(
          selectedRole, _phoneController.text.toString());

      if (success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => VerifyScreen(
                phoneNumber: _phoneController.text.toString(),
                selectedRole: selectedRole)));
      } else {
        // Show error message
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      color: const Color.fromARGB(255, 6, 57, 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Welcome",
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 23, 28, 34),
                ),
              ),
              Text(
                "You've been missed",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 102, 114, 128),
                ),
              ),
              const SizedBox(height: 46),

              Row(
                children: [
                  Text(
                    "Login as",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 135, 141, 186),
                    ),
                  ),
                  Text(
                    "*",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 255, 43, 43),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                value: _selectedRole,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 73, 13, 140),
                ),
                borderRadius: BorderRadius.circular(8),
                iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                dropdownColor: const Color.fromARGB(255, 243, 243, 253),
                decoration: InputDecoration(
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
                  hintText: 'Select',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 102, 114, 128),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 243, 243, 253),
                ),
                items: ['Super Admin', 'Center Owner', 'Therapist', 'Patient']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(
                            role,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 73, 13, 140),
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Text(
                    "Phone Number",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 135, 141, 186),
                    ),
                  ),
                  Text(
                    "*",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 255, 43, 43),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 46, 44, 52),
                  ),
                  decoration: InputDecoration(
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your number";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 52),

              // Login Button
              CustomButton(
                title: "Login",
                onTap: _handleLogin,
              )
            ],
          ),
        ),
      ),
    );
  }
}
