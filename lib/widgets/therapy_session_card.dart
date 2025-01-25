import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TherapySessionCard extends StatelessWidget {
  const TherapySessionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color.fromARGB(255, 235, 246, 237),
          )),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tags row
            Row(
              children: [
                TherapyTag(text: 'Thymus + Chest'),
                const SizedBox(width: 8),
                TherapyTag(text: 'Thymus + Chest'),
              ],
            ),
            const SizedBox(height: 16),
            // Date row
            Row(
              children: [
                Text(
                  'Date',
                  style: GoogleFonts.inter(
                    color: Color.fromARGB(255, 55, 61, 69),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  '2020-05-06 11:24:08',
                  style: GoogleFonts.inter(
                    color: Color.fromARGB(255, 147, 158, 170),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Given by row
            Row(
              children: [
                Text(
                  'Given by',
                  style: GoogleFonts.inter(
                    color: Color.fromARGB(255, 55, 61, 69),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  'Ankit',
                  style: GoogleFonts.inter(
                    color: Color.fromARGB(255, 147, 158, 170),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Color.fromARGB(255, 46, 44, 52),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
