import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_add_button.dart';
import 'package:therapy/widgets/therapist/add_therapist.dart';
import 'package:therapy/widgets/therapist/therapist_profile.dart';

class Therapist extends StatefulWidget {
  const Therapist({super.key});

  @override
  State<Therapist> createState() => _TherapistState();
}

class _TherapistState extends State<Therapist> {
  final List<Map<String, dynamic>> therapists = [
    {
      'name': 'Kathryn Murphy',
      'status': 'Active',
      'image': 'assets/profile.png'
    },
    {
      'name': 'Kristin Watson',
      'status': 'Inactive',
      'image': 'assets/profile.png'
    },
    {'name': 'Eleanor Pena', 'status': 'Active', 'image': 'assets/profile.png'},
    {
      'name': 'Annette Black',
      'status': 'Active',
      'image': 'assets/profile.png'
    },
    {'name': 'Cody Fisher', 'status': 'Active', 'image': 'assets/profile.png'},
    {'name': 'Jacob Jones', 'status': 'Active', 'image': 'assets/profile.png'},
    {
      'name': 'Esther Howard',
      'status': 'Inactive',
      'image': 'assets/profile.png'
    },
    {'name': 'Guy Hawkins', 'status': 'Active', 'image': 'assets/profile.png'},
    {
      'name': 'Darlene Robertson',
      'status': 'Active',
      'image': 'assets/profile.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
        ),
        title: Text("Therapist"),
        titleTextStyle: GoogleFonts.inter(
          color: Color.fromARGB(255, 23, 28, 34),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          CustomAddButton(
            title: "Add Therapist",
            onTap: () {
              Get.to(() => AddTherapist());
            },
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: ListView.builder(
          itemCount: therapists.length,
          itemBuilder: (context, index) {
            final therapist = therapists[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: () {
                  Get.to(
                      () => TherapistProfile(therapistName: therapist['name']));
                },
                child: ListTile(
                  tileColor: Color(0xFFFFFFFF),
                  contentPadding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Color(0xFFEBF6ED),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(therapist['image']),
                  ),
                  title: Flexible(child: Text(therapist['name'])),
                  titleTextStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF080C3E)),
                  trailing: Text(
                    therapist['status'],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: therapist['status'] == 'Active'
                          ? Color(0xFF41B877)
                          : Color(0xFFFF2B2B),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
