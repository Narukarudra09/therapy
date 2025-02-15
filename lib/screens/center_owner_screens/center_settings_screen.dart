import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/screens/center_owner_screens/announcement.dart';
import 'package:therapy/screens/center_owner_screens/therapist.dart';
import 'package:therapy/screens/center_owner_screens/update_phone_number.dart';
import 'package:therapy/screens/center_owner_screens/view_therapist.dart';
import 'package:therapy/widgets/custom_profile_screen.dart';

import '../../widgets/custom_appbar.dart';

class CenterSettingsScreen extends StatelessWidget {
  const CenterSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: '',
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 24, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF171C22),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            _buildMenuItem(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                Get.to(
                  () => CustomProfileScreen(
                    appBar: AppBar(
                      title: Text("Profile"),
                      titleTextStyle: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF171C22)),
                      elevation: 0,
                      shape: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
                      scrolledUnderElevation: 0,
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
                    onTap: () {
                      Get.to(() => UpdatePhoneNumber(
                            oldNumber: '',
                          ));
                    },
                    username: '',
                  ),
                );
              },
            ),
            SizedBox(
              height: 12,
            ),
            _buildMenuItem(
              icon: Icons.home_filled,
              title: 'Center Profile',
              onTap: () {
                Get.to(
                    () => ViewTherapist(imageUrl: 'assets/center_profile.png'));
              },
            ),
            SizedBox(
              height: 12,
            ),
            _buildMenuItem(
              icon: Icons.diversity_1,
              title: 'Therapist',
              onTap: () {
                Get.to(() => Therapist());
              },
            ),
            SizedBox(
              height: 12,
            ),
            _buildMenuItem(
              icon: Icons.article,
              title: 'Therapy',
              onTap: () {},
            ),
            SizedBox(
              height: 12,
            ),
            _buildMenuItem(
              icon: Icons.celebration,
              title: 'Announcement',
              onTap: () {
                Get.to(() => Announcement());
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 246, 244, 255),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 233, 255),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 73, 13, 140),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 26, 19, 65),
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color.fromARGB(255, 186, 180, 216),
            size: 24,
          ),
        ],
      ),
    ),
  );
}
