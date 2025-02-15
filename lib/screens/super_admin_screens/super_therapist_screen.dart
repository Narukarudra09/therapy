import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/therapist/add_therapist.dart';

import '../../widgets/custom_add_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_listtile.dart';
import '../../widgets/therapist/therapist_profile.dart';

class SuperTherapistsScreen extends StatefulWidget {
  const SuperTherapistsScreen({super.key});

  @override
  State<SuperTherapistsScreen> createState() => _SuperTherapistsScreenState();
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

List<String> roles = [
  "center owner",
  "Therapist",
  "center owner",
  "Therapist",
  "center owner",
  "Therapist",
  "center owner",
];

class _SuperTherapistsScreenState extends State<SuperTherapistsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: '',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Center Member",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 24, 8, 41),
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  CustomAddButton(
                    title: "Add Center Member",
                    onTap: () {
                      Get.to(AddTherapist());
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
                    subtitle: roles[index],
                    onTap: () {
                      Get.to(TherapistProfile(
                        therapistName: names[index],
                      ));
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
