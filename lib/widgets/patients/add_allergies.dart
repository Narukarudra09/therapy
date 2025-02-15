import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state_controllers/super_patient_controller.dart';
import '../custom_add_button.dart';

class AddAllergies extends StatelessWidget {
  const AddAllergies({super.key});

  @override
  Widget build(BuildContext context) {
    final SuperPatientController controller = Get.put(SuperPatientController());

    void saveAllergies() {
      final selected = controller.getSelectedAllergies();
      Get.back(result: selected);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Allergies"),
        actions: [
          GestureDetector(
            onTap: saveAllergies,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 65, 184, 119),
              ),
              child: Center(
                child: Text(
                  "Save",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String newAllergy = '';
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(0),
                        titlePadding: EdgeInsets.only(
                            left: 21, right: 21, top: 24, bottom: 15),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        insetPadding: EdgeInsets.symmetric(horizontal: 20),
                        actionsPadding: EdgeInsets.only(top: 24, bottom: 32),
                        title: Center(child: Text('Add New')),
                        content: SizedBox(
                          width: 500,
                          height: MediaQuery.of(context).size.height * 0.119,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 24),
                                child: TextField(
                                  onChanged: (value) {
                                    newAllergy = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 232, 233, 241)),
                                    ),
                                    hintText: 'Write Here',
                                  ),
                                ),
                              ),
                              Divider()
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 162,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  "No",
                                  style: GoogleFonts.inter(
                                    color: Color.fromARGB(255, 118, 141, 139),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (newAllergy.isNotEmpty) {
                                controller.addAllergy(newAllergy);
                              }
                              Get.back();
                            },
                            child: Container(
                              width: 162,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 65, 184, 119),
                              ),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: GoogleFonts.sora(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 254, 254, 255),
                      border: Border.all(
                          color: Color.fromARGB(255, 224, 227, 231))),
                  child: Center(
                    child: CustomAddButton(
                      title: "Add New",
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
              ),
              Obx(() {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.allergies.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return CheckboxListTile(
                        side: BorderSide(
                            color: Color.fromARGB(255, 224, 227, 231),
                            width: 2),
                        activeColor: Color.fromARGB(255, 65, 184, 119),
                        checkboxShape: OvalBorder(),
                        title: Text(controller.allergies[index]),
                        value: controller.selectedAllergies[index],
                        onChanged: (value) {
                          controller.toggleSelection(index);
                        },
                      );
                    });
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
