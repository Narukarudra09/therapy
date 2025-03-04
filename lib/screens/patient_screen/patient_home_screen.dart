import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/patient_provider.dart';
import 'package:therapy/widgets/custom_appbar.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PatientProvider>(context);
    int completedDays = controller.completedDays;
    int totalDays = controller.totalDays;

    return Consumer<PatientProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            userName: provider.patient?.name ?? "User",
          ),
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
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFAB83E2),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100),
                                      ),
                                    ),
                                    width: 100,
                                    height: 100,
                                  ),
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
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFAB83E2),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                      ),
                                    ),
                                    width: 100,
                                    height: 100,
                                  ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    spacing: 2,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "$completedDays Days",
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
                                        "$totalDays Days",
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
                                  Color(0xFF490D8C),
                                ),
                              ),
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
                                  ),
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
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4FC283),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                      ),
                                    ),
                                    width: 80,
                                    height: 80,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                  if (controller.records.isEmpty)
                    Center(
                      child: Text(
                        "No therapy history",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF180829),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.records.length,
                      itemBuilder: (context, index) {
                        final record = controller.records[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color.fromARGB(255, 235, 246, 237),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Tags row
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: record['therapyTypes']
                                      .map<Widget>(
                                        (therapy) => TherapyTag(text: therapy),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: 16),
                                _buildInfoRow(
                                  'Date',
                                  '${record['date'].day}-${record['date'].month}-${record['date'].year} ${record['time']}',
                                ),
                                const SizedBox(height: 8),
                                _buildInfoRow('Given by', record['givenBy']),
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
      },
    );
  }
}

Widget _buildInfoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 55, 61, 69),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(width: 8),
      Flexible(
        flex: 2,
        child: Text(
          value,
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 147, 158, 170),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

class TherapyTag extends StatelessWidget {
  final String text;

  const TherapyTag({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 233, 233),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 46, 44, 52),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
