import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../payment_history_item.dart';

class PatientPaymentHistory extends StatelessWidget {
  final String patientName;

  const PatientPaymentHistory({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          patientName,
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 8, 12, 62),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 20, right: 20),
        child: ListView.separated(
          itemCount: 15,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final isDebit = index == 4;
            return PaymentHistoryItem(
              isDebit: isDebit,
              patientName: patientName,
            );
          },
        ),
      ),
    );
  }
}
