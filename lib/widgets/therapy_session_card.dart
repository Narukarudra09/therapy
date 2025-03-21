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
              children: [
                TherapyTag(text: 'Thymus + Chest'),
                TherapyTag(text: 'Thymus + Chest'),
              ],
            ),
            const SizedBox(height: 16),
            // Date row
            _buildInfoRow('Date', DateTime.now().toString()),
            const SizedBox(height: 8),
            // Given by row
            _buildInfoRow('Given by', 'Ankit'),
          ],
        ),
      ),
    );
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
