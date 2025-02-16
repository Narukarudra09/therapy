import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_add_button.dart';
import 'package:therapy/widgets/custom_appbar.dart';
import 'package:therapy/widgets/custom_listtile.dart';
import 'package:therapy/widgets/patients/add_patients.dart';
import 'package:therapy/widgets/patients/patient_detail.dart';

import '../../state_controllers/super_patient_controller.dart';

class SuperPatientScreen extends StatelessWidget {
  const SuperPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SuperPatientController controller =
        Get.find<SuperPatientController>();
    return Scaffold(
      appBar: CustomAppBar(
        userName: '',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(child: Text(controller.error.value));
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
                        Get.to(() => AddPatients());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.patients.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final patient = controller.patients[index];
                    return CustomListTile(
                      title: patient.name,
                      subtitle: patient.email,
                      onTap: () {
                        controller.selectPatient(patient.id);
                        Get.to(() => PatientDetail(patientName: patient.name));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
