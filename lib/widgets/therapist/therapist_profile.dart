import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TherapistProfile extends StatelessWidget {
  final String therapistName;
  final String role;

  const TherapistProfile(
      {super.key, required this.therapistName, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          therapistName,
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 23, 28, 34),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/profile.png"),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Basic Info Section
              Text(
                'Basic Info',
                style: GoogleFonts.inter(
                  color: Color.fromARGB(255, 23, 28, 34),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              _buildInfoItem(therapistName, Icons.account_circle),
              _buildInfoItem('ankitdangi@a2d.co.in', Icons.mail_outline),
              _buildInfoItem('9509965856', Icons.edit_outlined),
              _buildInfoItem(role, Icons.edit_outlined),
              _buildInfoItem('Jk vihar', Icons.edit_outlined),
              _buildInfoItem('Male', Icons.calendar_today_outlined),

              const SizedBox(height: 16),
              Divider(
                color: Color.fromARGB(255, 218, 218, 218),
              ),
              const SizedBox(height: 16),
              Text(
                'KYC Documents',
                style: GoogleFonts.inter(
                  color: Color.fromARGB(255, 46, 44, 52),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              _buildDocumentItem('aadhar.pdf'),
              _buildDocumentItem('pan.pdf'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              color: Color.fromARGB(255, 46, 44, 52),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(icon, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String filename) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 250, 250, 250),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color.fromARGB(255, 232, 233, 241),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.picture_as_pdf,
            color: Colors.red,
            size: 25,
          ),
          const SizedBox(width: 12),
          Text(
            filename,
            style: GoogleFonts.inter(
              color: Color.fromARGB(255, 46, 44, 52),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
