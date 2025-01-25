import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientProfile extends StatelessWidget {
  final String patientName;

  const PatientProfile({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    List<String> allergies = ['Cheese', 'Cheese', 'Cheese'];
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Basic Info',
                style: GoogleFonts.inter(
                  color: Color.fromARGB(255, 23, 28, 34),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.account_circle, patientName),
              _buildInfoRow(Icons.email_outlined, 'ankitdangi@a2d.co.in'),
              _buildInfoRow(Icons.phone_android, '9509965856'),
              _buildInfoRow(Icons.calendar_today_outlined, 'Male'),
              const SizedBox(height: 16),
              const Divider(
                color: Color.fromARGB(255, 218, 218, 218),
              ),
              const SizedBox(height: 32),
              Text(
                'Medical Profile',
                style: GoogleFonts.inter(
                  color: Color.fromARGB(255, 23, 28, 34),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildSection(
                'Blood Group',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: Color.fromARGB(255, 232, 233, 241),
                      endIndent: 16,
                      indent: 16,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                      child: Text(
                        'A+',
                        style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 23, 28, 34),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildSection(
                'Allergies',
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      allergies.length,
                      (index) => Chip(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(0),
                        labelPadding: EdgeInsets.symmetric(horizontal: 8),
                        label: Text(allergies[index]),
                        labelStyle: GoogleFonts.inter(
                          color: Color.fromARGB(255, 46, 44, 52),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor: Color.fromARGB(255, 233, 233, 233),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildSection(
                'Medical Records',
                child: Column(children: [
                  const Divider(
                    color: Color.fromARGB(255, 232, 233, 241),
                    endIndent: 16,
                    indent: 16,
                  ),
                  Column(
                    children: List.generate(
                      2,
                      (index) => _buildRecordItem(
                        'alergic khasi',
                        '12-05-2023 • 12:00 am',
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              _buildSection(
                'Past Prescriptions',
                child: Column(
                  children: [
                    const Divider(
                      color: Color.fromARGB(255, 232, 233, 241),
                      endIndent: 16,
                      indent: 16,
                    ),
                    Column(
                      children: List.generate(
                        3,
                        (index) => _buildRecordItem(
                            'alergic khasi', '12-05-2023 • 12:00 am'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              color: Color.fromARGB(255, 46, 44, 52),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Icon(
            icon,
            size: 20,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, {required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(
          255,
          250,
          250,
          250,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color.fromARGB(255, 232, 233, 241)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: Color.fromARGB(255, 23, 28, 34),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildRecordItem(String title, String date) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            'assets/X-ray.png',
            width: 40,
            height: 40,
          ),
          title: Text(title),
          titleTextStyle: GoogleFonts.inter(
            color: Color.fromARGB(255, 46, 44, 52),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          subtitle: Text(
            date,
            style: GoogleFonts.inter(
              color: Color.fromARGB(255, 147, 158, 170),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
