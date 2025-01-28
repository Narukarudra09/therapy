import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/patients/patient_payment_history.dart';
import 'package:therapy/widgets/patients/patient_profile.dart';
import 'package:therapy/widgets/patients/patient_therapy_history.dart';

class PatientDetail extends StatelessWidget {
  final String patientName;

  const PatientDetail({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.person,
              title: 'Patient Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientProfile(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              icon: Icons.sticky_note_2,
              title: 'Therapy History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientTherapyHistory(
                            patientName: patientName,
                          )),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              icon: Icons.receipt_long,
              title: 'Payment History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientPaymentHistory(
                            patientName: patientName,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 246, 244, 255),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 233, 255),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color.fromARGB(255, 73, 13, 140),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 26, 19, 65),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color.fromARGB(255, 186, 180, 216),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
