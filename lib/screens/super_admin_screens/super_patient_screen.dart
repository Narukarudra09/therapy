import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_add_button.dart';
import 'package:therapy/widgets/custom_appbar.dart';
import 'package:therapy/widgets/custom_listtile.dart';
import 'package:therapy/widgets/patients/add_patients.dart';
import 'package:therapy/widgets/patients/patient_detail.dart';

import '../../state_controllers/super_patient_controller.dart';

class SuperPatientScreen extends StatefulWidget {
  const SuperPatientScreen({super.key});

  @override
  State<SuperPatientScreen> createState() => _SuperPatientScreenState();
}

class _SuperPatientScreenState extends State<SuperPatientScreen> {
  final SuperPatientController _controller = Get.find<SuperPatientController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchPatients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: '',
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.error.value.isNotEmpty) {
          return Center(child: Text(_controller.error.value));
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
                  itemCount: _controller.patients.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final patient = _controller.patients[index];
                    return CustomListTile(
                      title: patient.name,
                      subtitle: patient.email,
                      onTap: () {
                        _controller.selectPatient(patient.id);
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
