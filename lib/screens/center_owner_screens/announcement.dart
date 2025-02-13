import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/screens/center_owner_screens/add_announcement.dart';
import 'package:therapy/widgets/custom_add_button.dart';

import '../../state_controllers/super_center_controller.dart';

class Announcement extends StatelessWidget {
  const Announcement({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SuperCenterController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
        ),
        title: Text("Announcement"),
        titleTextStyle: GoogleFonts.inter(
          color: Color.fromARGB(255, 23, 28, 34),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          CustomAddButton(
            title: "Add Announcement",
            onTap: () async {
              final result = await Get.to(() => AddAnnouncement());
              if (result != null) {
                controller.addAnnouncement(result);
              }
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shrinkWrap: true,
          itemCount: controller.announcements.length,
          itemBuilder: (context, index) {
            final announcement = controller.announcements[index];

            return Container(
              key: Key(index.toString()),
              // Ensure unique key
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(12),
              width: Get.width,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Color(0xFFEBF6ED),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement['message'],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF2E2C34),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      announceInfo("Date", announcement['date']),
                      announceInfo('Medium', announcement['medium']),
                      announceInfo('Patient', announcement['patient']),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

Widget announceInfo(String title, String info) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF373D45)),
      ),
      Text(
        info,
        style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF939EAA)),
      ),
    ],
  );
}
