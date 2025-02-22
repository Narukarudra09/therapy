import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/super_center_provider.dart';
import '../../widgets/center/add_holidays.dart';
import '../../widgets/center/add_therapy_center.dart';
import '../../widgets/center/add_working_hours.dart';

class ViewTherapist extends StatelessWidget {
  final String imageUrl;

  ViewTherapist({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SuperCenterProvider>(context);

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
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTherapyCenter(isEditing: true),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/edit.svg",
                          width: 24,
                          height: 24,
                        ),
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
                    minTileHeight: 0,
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
                    minTileHeight: 0,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WorkingHoursScreen(isEditing: true),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/edit.svg",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Column(
                    children: controller.openingTimes.entries.map((entry) {
                      final day = entry.key;
                      final openingTime = entry.value;
                      final closingTime = controller.closingTimes[day];
                      final isHoliday = controller.holidays[day] != null;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              day,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4E5661),
                              ),
                            ),
                            Text(
                              isHoliday
                                  ? "Holiday"
                                  : "${openingTime.format(context)} - ${closingTime?.format(context)}",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    isHoliday ? Colors.red : Color(0xFF939EAA),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HolidayScreen(),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/edit.svg",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.holidays.length,
                    itemBuilder: (BuildContext context, int index) {
                      final holiday =
                          controller.holidays.entries.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              holiday.value?.message ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4E5661),
                              ),
                            ),
                            Text(
                              'Holiday',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
