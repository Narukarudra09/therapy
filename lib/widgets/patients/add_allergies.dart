import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_add_button.dart';

import '../../state_controllers/super_patient_controller.dart';

class AddAllergies extends StatefulWidget {
  const AddAllergies({super.key});

  @override
  State<AddAllergies> createState() => _AddAllergiesState();
}

final List<String> allergies = [
  'Cheese',
  'Curd',
  'Egg',
  'Garlic',
  'Gluten',
  'Lemon',
  'Meat',
  'Milk',
  'Nuts',
  'Oats',
  'Other Fruits',
  'Peanut',
  'Peppers',
  'Preserved Foods',
  'Shellfish/Fish',
  'Soya',
];

class _AddAllergiesState extends State<AddAllergies> {
  final List<bool> selectedAllergies =
      List.generate(allergies.length, (_) => false);

  void _saveAllergies() {
    final selected = selectedAllergies
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => allergies[entry.key])
        .toList();

    final patientId =
        Get.find<SuperPatientController>().selectedPatient.value?.id;

    if (patientId != null) {
      for (var allergy in selected) {
        Get.find<SuperPatientController>().addAllergy(patientId, allergy);
      }
      Get.back(); // Navigate back after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
        scrolledUnderElevation: 0,
        title: Text("Allergies"),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 23, 28, 34),
        ),
        actions: [
          GestureDetector(
            onTap: _saveAllergies,
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
                    // Adjust max width as needed
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
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
        ),
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
                        backgroundColor: Colors.white,
                        contentPadding: EdgeInsets.all(0),
                        titlePadding: EdgeInsets.only(
                            left: 21, right: 21, top: 24, bottom: 15),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        insetPadding: EdgeInsets.symmetric(horizontal: 20),
                        actionsPadding: EdgeInsets.only(top: 24, bottom: 32),
                        title: Center(child: Text('Add New')),
                        titleTextStyle: GoogleFonts.sora(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
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
                                        color:
                                            Color.fromARGB(255, 232, 233, 241),
                                      ),
                                    ),
                                    hintText: 'Write Here',
                                    hintStyle: GoogleFonts.inter(
                                      color: Color.fromARGB(255, 46, 44, 52),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                setState(() {
                                  allergies.add(newAllergy);
                                  selectedAllergies.add(true);
                                });
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
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: allergies.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    side: BorderSide(
                        color: Color.fromARGB(255, 224, 227, 231), width: 2),
                    activeColor: Color.fromARGB(255, 65, 184, 119),
                    checkboxShape: OvalBorder(),
                    title: Text(allergies[index]),
                    value: selectedAllergies[index],
                    onChanged: (value) {
                      setState(() {
                        selectedAllergies[index] = value!;
                      });
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
