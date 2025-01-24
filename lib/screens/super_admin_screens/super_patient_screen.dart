import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/add_patients.dart';
import 'package:therapy/widgets/custom_add_button.dart';
import 'package:therapy/widgets/custom_listtile.dart';

class SuperPatientScreen extends StatefulWidget {
  const SuperPatientScreen({super.key});

  @override
  State<SuperPatientScreen> createState() => _SuperPatientScreenState();
}

class _SuperPatientScreenState extends State<SuperPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CustomListTile(
                      title: "Rudrapratap Singh Naruka",
                      subtitle: "narukarudra2@gmail.com");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
