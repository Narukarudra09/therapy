import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:therapy/screens/auth/login_screen.dart';

import '../providers/patient_provider.dart';
import '../providers/auth_provider.dart';

class CustomProfileScreen extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final void Function()? onTap;
  final TextEditingController usernameController;
  final String phone;

  const CustomProfileScreen({
    super.key,
    required this.appBar,
    required this.onTap,
    required this.usernameController,
    required this.phone,
  });

  @override
  State<CustomProfileScreen> createState() => _CustomProfileScreenState();
}

class _CustomProfileScreenState extends State<CustomProfileScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientProvider>(context);
    final patient = provider.patient;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: widget.appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue[200],
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage("assets/profile.png")
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Full Name',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: widget.usernameController,
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Mobile Number',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 135, 141, 186),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '*',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 255, 43, 43),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                readOnly: true,
                initialValue: widget.phone,
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
                  suffixIcon: InkWell(
                    onTap: widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset("assets/edit.svg"),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'City',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: patient?.city ?? 'Bhilwara',
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                iconEnabledColor: const Color(0xFF171C22),
                iconDisabledColor: const Color(0xFF171C22),
                dropdownColor: const Color.fromARGB(255, 243, 243, 253),
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
                items: ['Bhilwara', 'Jaipur'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: FittedBox(child: Text(value)),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 32),
              InkWell(
                onTap: () {
                  authProvider.logout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logout',
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.red,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
