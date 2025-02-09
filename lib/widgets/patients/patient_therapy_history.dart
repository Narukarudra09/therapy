import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../therapy_session_card.dart';

class PatientTherapyHistory extends StatelessWidget {
  final String patientName;

  const PatientTherapyHistory({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          patientName,
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 8, 12, 62),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
        itemCount: 6,
        itemBuilder: (context, index) {
          return TherapySessionCard();
        },
      ),
    );
  }
}
