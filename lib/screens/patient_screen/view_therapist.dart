import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTherapist extends StatefulWidget {
  const ViewTherapist({super.key});

  @override
  State<ViewTherapist> createState() => _ViewTherapistState();
}

class _ViewTherapistState extends State<ViewTherapist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
        scrolledUnderElevation: 0,
        title: Text(
          "Details",
          style: GoogleFonts.inter(
            color: Color(0xFF171C22),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
