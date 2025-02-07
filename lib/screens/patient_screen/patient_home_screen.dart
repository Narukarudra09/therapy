import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_appbar.dart';
import 'package:therapy/widgets/therapy_session_card.dart';

class PatientHomeScreen extends StatelessWidget {
  final String patientName;

  const PatientHomeScreen({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    int completedDays = 4;
    int totalDays = 15;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFB491E6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Positioned(
                      left: 270,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xFFAB83E2),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomLeft: Radius.circular(100),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFAB83E2),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      bottomRight: Radius.circular(100),
                                    )),
                                width: 100,
                                height: 100,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xFFAB83E2),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      bottomRight: Radius.circular(100),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFAB83E2),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomLeft: Radius.circular(100),
                                    )),
                                width: 100,
                                height: 100,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        spacing: 18,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                spacing: 2,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Completed",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "4 Days",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF490D8C),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                spacing: 2,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "15 Days",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF490D8C),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          LinearProgressIndicator(
                            value: completedDays / totalDays,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF490D8C)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF41B877),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  alignment: Alignment.centerLeft,
                  children: [
                    Positioned(
                      right: 290,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4FC283),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(100),
                                    bottomLeft: Radius.circular(100),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF4FC283),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ),
                                ),
                                width: 80,
                                height: 80,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Color(0xFF4FC283),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      bottomRight: Radius.circular(100),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF4FC283),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomLeft: Radius.circular(100),
                                    )),
                                width: 80,
                                height: 80,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                                size: 42,
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "12-05-2023",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Happy Holi",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "Holiday",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Text(
                "Therapy History",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF180829),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return TherapySessionCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
