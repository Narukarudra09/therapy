import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/screens/super_admin_screens/view_therapist.dart';

import '../../widgets/center/add_therapy_center.dart';
import '../../widgets/custom_add_button.dart';
import '../../widgets/custom_appbar.dart';

class SuperCentersScreen extends StatefulWidget {
  const SuperCentersScreen({super.key});

  @override
  State<SuperCentersScreen> createState() => _SuperCentersScreenState();
}

class _SuperCentersScreenState extends State<SuperCentersScreen> {
  @override
  Widget build(BuildContext context) {
    final String title = "Gardens Galleria Par";
    final String subTitle = "Sector 38, Noida, Uttar Pradesh 201301";
    final String imageUrl = "assets/center_profile.png";
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
                      "Therapy Center",
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
                    title: "Create Therapy Center",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (AddTherapyCenter())));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (ViewTherapist(
                            imageUrl: imageUrl,
                          )),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFEBF6ED),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align items to top
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            child: Image.asset(
                              imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromARGB(255, 8, 12, 62),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                  SizedBox(height: 4),
                                  // Add space between texts
                                  Text(
                                    subTitle,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 147, 158, 170),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
