import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/widgets/custom_add_button.dart';
import 'package:therapy/widgets/custom_appbar.dart';
import 'package:therapy/widgets/custom_listtile.dart';
import 'package:therapy/widgets/patients/add_patients.dart';
import 'package:therapy/widgets/patients/patient_detail.dart';

import '../../providers/super_patient_provider.dart';

class SuperPatientScreen extends StatelessWidget {
  const SuperPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: '',
      ),
      body: Consumer<SuperPatientProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xFF40B777),
            ));
          }

          if (provider.error.isNotEmpty) {
            return Center(child: Text(provider.error));
          }

          return Padding(
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
                        softWrap: true,
                      ),
                      CustomAddButton(
                        title: "Add Patients",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPatients()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.patients.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final patient = provider.patients[index];
                      return CustomListTile(
                        title: patient.name!,
                        subtitle: patient.email!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PatientDetail(patientName: patient.name!)),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
