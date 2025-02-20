import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../state_controllers/super_patient_controller.dart';
import '../../widgets/patients/add_allergies.dart';
import 'blood_group.dart';

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final SuperPatientController controller = Get.put(SuperPatientController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
        scrolledUnderElevation: 0,
        title: Text(
          'Medical History',
          style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF171C22)),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 20),
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 65, 184, 119),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      "Save",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
              'Blood Group',
              Obx(() => ListTile(
                    title: Text(
                      controller.bloodGroup.value,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )), onTap: () async {
            final newBloodGroup = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BloodGroup(),
              ),
            );
            if (newBloodGroup != null) {
              controller.updateBloodGroup(newBloodGroup);
            }
          }),
          const SizedBox(height: 16),
          _buildSection(
              'Allergies',
              Obx(() => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 4,
                      children: controller.allergies
                          .map((allergy) => Chip(
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: EdgeInsets.all(0),
                                labelPadding: EdgeInsets.only(left: 8),
                                label: Text(allergy),
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  controller.deleteAllergy(allergy);
                                },
                                backgroundColor: Colors.grey[200],
                              ))
                          .toList(),
                    ),
                  )), onTap: () async {
            final selectedAllergies = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAllergies(),
              ),
            );
            if (selectedAllergies != null &&
                selectedAllergies is List<String>) {
              controller.allergies.assignAll(selectedAllergies);
            }
          }),
          const SizedBox(height: 16),
          _buildSection(
            'Medical Records',
            Obx(() => Column(
                  children: controller.medicalRecords
                      .map((record) => _buildRecordItem(
                            record['title'],
                            record['date'],
                            record['imagePath'],
                            onDelete: () => controller.deleteRecord(record),
                          ))
                      .toList(),
                )),
            onTap: () => controller.pickImage(ImageSource.gallery, false),
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Past Prescriptions',
            Obx(() => Column(
                  children: controller.prescriptions
                      .map((prescription) => _buildRecordItem(
                            prescription['title'],
                            prescription['date'],
                            prescription['imagePath'],
                            onDelete: () =>
                                controller.deletePrescription(prescription),
                          ))
                      .toList(),
                )),
            onTap: () => controller.pickImage(ImageSource.gallery, true),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content, {void Function()? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        border: Border.all(
          color: Color(0xFFE8E9F1),
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.add,
                    color: const Color(0xFF6750A4),
                  ),
                ),
              ],
            ),
          ),
          content,
        ],
      ),
    );
  }

  Widget _buildRecordItem(String title, String date, String imagePath,
      {void Function()? onDelete}) {
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
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: onDelete,
      ),
    );
  }
}
