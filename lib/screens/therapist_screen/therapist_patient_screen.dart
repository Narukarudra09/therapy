import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/therapist_provider.dart';

class TherapistPatientScreen extends StatelessWidget {
  const TherapistPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TherapistProvider>(
      builder: (context, therapistProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                      "assets/logoG.svg",
                      width: 17,
                    ),
                    Text(
                      "Therapy",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 6, 57, 24),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Welcome ${therapistProvider.therapist?.name ?? 'Therapist'}",
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 81, 92, 104),
                  ),
                ),
              ],
            ),
            actions: [
              GestureDetector(
                child: CircleAvatar(
                  backgroundImage: therapistProvider.profileImageUrl != null
                      ? NetworkImage(therapistProvider.profileImageUrl!)
                          as ImageProvider
                      : const AssetImage("assets/profile.png") as ImageProvider,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
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
                              Text(
                                "Patient Name",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF080C3E)),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  TherapyTag(text: 'Thymus + Chest'),
                                  TherapyTag(text: 'Thymus + Chest'),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Date row
                              _buildInfoRow(
                                'Date',
                                "${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year} ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}:${DateTime.now().second.toString()}",
                              ),
                              const SizedBox(height: 8),
                              // Given by row
                              _buildInfoRow('Given by', 'Ankit'),
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
