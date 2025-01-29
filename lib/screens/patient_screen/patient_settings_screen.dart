import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientSettingsScreen extends StatelessWidget {
  const PatientSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/logoG.svg",
                  width: 17,
                ),
                Text(
                  "Therapy",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 6, 57, 24),
                  ),
                ),
              ],
            ),
            Text(
              "Welcome",
              style: GoogleFonts.sora(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 81, 92, 104),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
              child: CircleAvatar(
            backgroundImage: AssetImage("assets/profile.png"),
          )),
          SizedBox(
            width: 20,
          ),
        ],
      ),
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
            _buildMenuItem(icon: Icons.person, title: 'Profile', onTap: () {}),
            _buildMenuItem(
                icon: Icons.history, title: 'Medical History', onTap: () {}),
            _buildMenuItem(
                icon: Icons.developer_mode_outlined,
                title: 'About Developer',
                onTap: () {}),
            _buildMenuItem(
                icon: Icons.report_problem,
                title: 'Report a Problem',
                onTap: () {}),
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
