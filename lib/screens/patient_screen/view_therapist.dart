import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state_controllers/super_center_controller.dart';

class ViewTherapist extends StatelessWidget {
  final String imageUrl;
  final SuperCenterController controller = Get.put(SuperCenterController());

  ViewTherapist({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
        ),
        scrolledUnderElevation: 0,
        title: Text(
          "Details",
          style: GoogleFonts.inter(
            color: Color(0xFF171C22),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: 160,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: EdgeInsets.only(top: 24, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage("assets/profile.png")),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. N Sera',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000)),
                          ),
                          Text(
                            'Owner',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF939EAA),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Contact Details',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF042710)),
                  ),
                  SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.phone_in_talk_sharp,
                      color: Color(0xFF939EAA),
                    ),
                    title: Text('9509965856'),
                    titleTextStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF939EAA)),
                  ),
                  ListTile(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFEBF6ED),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.mail_outline_rounded,
                      color: Color(0xFF939EAA),
                    ),
                    title: Text('mailto:mail@example.com'),
                    titleTextStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF939EAA)),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'About',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF042710)),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF939EAA)),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 12),
                  Divider(
                    color: Color(0xFFEBF6ED),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Location',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF042710)),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Pandariya, kawardha(kabirdham), CHATTISGARH',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF939EAA)),
                  ),
                  SizedBox(height: 12),
                  Divider(
                    color: Color(0xFFEBF6ED),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Fees',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF042710)),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '₹1000/Therapy',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF939EAA)),
                  ),
                  SizedBox(height: 12),
                  Divider(
                    color: Color(0xFFEBF6ED),
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Working Hours',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF042710)),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              days[index],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF4E5661),
                              ),
                            ),
                            Text(
                              '10:15 am–11 pm',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF939EAA),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  Divider(
                    color: Color(0xFFEBF6ED),
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Holiday',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF042710)),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Obx(() {
                    final holidays = controller.holidays.entries
                        .where((entry) => entry.value.date != null)
                        .toList();

                    if (holidays.isEmpty) {
                      return Text(
                        'No holidays added yet.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      );
                    }

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: holidays.length,
                      itemBuilder: (BuildContext context, int index) {
                        final holiday = holidays[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${holiday.value.message}'.split(' ')[0],
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF4E5661),
                                ),
                              ),
                              Text(
                                "Holiday",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF939EAA),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
