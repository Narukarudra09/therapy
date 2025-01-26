import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_add_button.dart';
import 'package:therapy/widgets/custom_listtile.dart';
import 'package:therapy/widgets/patients/add_patients.dart';
import 'package:therapy/widgets/patients/patient_detail.dart';

class SuperPatientScreen extends StatefulWidget {
  const SuperPatientScreen({super.key});

  @override
  State<SuperPatientScreen> createState() => _SuperPatientScreenState();
}

List<String> names = [
  "Rudrapratap Singh Naruka",
  "Rudrapratap",
  "Rudrapratap Singh",
  "Rudra",
  "Naruka",
  "Singh",
  "Pratap",
];

List<String> email = [
  "narukarudra2@gmail.com",
  "narukarudra2@gmail.com",
  "narukarudra2@gmail.com",
  "narukarudra2@gmail.com",
  "narukarudra2@gmail.com",
  "narukarudra2@gmail.com",
  "narukarudra2@gmail.com",
];

class _SuperPatientScreenState extends State<SuperPatientScreen> {
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
              "Welcome Ankit Dangi",
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
        padding: const EdgeInsets.only(top: 16.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Patients",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 24, 8, 41),
                    ),
                  ),
                  CustomAddButton(
                    title: "Add Patients",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPatients()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 7,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CustomListTile(
                    title: names[index],
                    subtitle: email[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientDetail(
                            patientName: names[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
