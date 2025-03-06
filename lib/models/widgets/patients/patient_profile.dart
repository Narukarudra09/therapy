import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/super_patient_provider.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SuperPatientProvider>(context);
    final patient = provider.selectedPatient;

    if (patient == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
          ),
          scrolledUnderElevation: 0,
          title: Text(
            "Patient Profile",
            style: GoogleFonts.inter(
              color: Color.fromARGB(255, 8, 12, 62),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Center(
          child: Text(
            "No patient selected",
            style: GoogleFonts.inter(
              color: Color.fromARGB(255, 23, 28, 34),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          patient.name!,
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
              _buildInfoRow(Icons.account_circle, patient.name!),
              _buildInfoRow(Icons.email_outlined, patient.email!),
              _buildInfoRow(Icons.phone_android, patient.phone!),
              _buildInfoRow(Icons.calendar_today_outlined,
                  patient.gender ?? 'Not Specified'),
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
                        patient.bloodGroup!,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: Color.fromARGB(255, 232, 233, 241),
                      endIndent: 16,
                      indent: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          patient.allergies!.length,
                          (index) => Chip(
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: EdgeInsets.all(0),
                            labelPadding: EdgeInsets.symmetric(horizontal: 8),
                            label: Text(patient.allergies![index]),
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
                  ],
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
                    children: provider.medicalRecords
                        .map((record) => _buildRecordItem(
                              record['title'],
                              record['date'],
                              record['imagePath'],
                            ))
                        .toList(),
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
                      children: provider.prescriptions
                          .map((prescription) => _buildRecordItem(
                                prescription['title'],
                                prescription['date'],
                                prescription['imagePath'],
                              ))
                          .toList(),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: Color.fromARGB(255, 46, 44, 52),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
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
        color: Color.fromARGB(255, 250, 250, 250),
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

  Widget _buildRecordItem(
    String title,
    String date,
    String imagePath,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
          image: imagePath != null
              ? DecorationImage(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
      title: Text(title),
      titleTextStyle: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF2E2C34)),
      subtitle: Text(date),
      subtitleTextStyle:
          GoogleFonts.inter(fontSize: 12, color: Color(0xFF939EAA)),
    );
  }
}
