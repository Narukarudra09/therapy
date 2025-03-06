import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/super_center_provider.dart';

class TherapistProfile extends StatelessWidget {
  final String therapistName;

  const TherapistProfile({
    super.key,
    required this.therapistName,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SuperCenterProvider>(context);
    final therapist =
        provider.therapists.firstWhere((t) => t.name == therapistName);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
        ),
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

              _buildInfoItem(therapist.name, Icons.account_circle),
              _buildInfoItem(therapist.email, Icons.mail_outline),
              _buildInfoItem(therapist.phoneNumber, Icons.phone),
              _buildInfoItem(therapist.centerName, Icons.location_on),
              _buildInfoItem(therapist.gender, Icons.person),

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

              ...therapist.kycDocuments
                  .map((filename) => _buildDocumentItem(filename))
                  .toList(),
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
