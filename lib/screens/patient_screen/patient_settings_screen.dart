import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/screens/patient_screen/report_screen.dart';
import 'package:therapy/widgets/custom_appbar.dart';
import 'package:therapy/widgets/custom_profile_screen.dart';

import 'medical_history.dart';

class PatientSettingsScreen extends StatelessWidget {
  const PatientSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 24, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF171C22),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            _buildMenuItem(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                Get.to(CustomProfileScreen());
              },
            ),
            SizedBox(
              height: 12,
            ),
            _buildMenuItem(
              icon: Icons.history,
              title: 'Medical History',
              onTap: () {
                Get.to(MedicalHistory());
              },
            ),
            SizedBox(
              height: 12,
            ),
            _buildMenuItem(
              icon: Icons.developer_mode_outlined,
              title: 'About Developer',
              onTap: () {},
            ),
            SizedBox(
              height: 12,
            ),
            _buildMenuItem(
              icon: Icons.report_problem,
              title: 'Report a Problem',
              onTap: () {
                Get.to(ReportScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
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
