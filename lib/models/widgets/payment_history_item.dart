import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentHistoryItem extends StatelessWidget {
  final String patientName;
  final bool isDebit;

  const PaymentHistoryItem({
    super.key,
    this.isDebit = false,
    required this.patientName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color:
                  isDebit ? const Color(0xFFFFEBEB) : const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.attach_money,
              color: isDebit
                  ? const Color.fromARGB(255, 255, 43, 43)
                  : const Color.fromARGB(255, 65, 184, 119),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Name and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: GoogleFonts.inter(
                    color: Color.fromARGB(255, 8, 12, 62),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '23-02-2021•11:00 AM',
                  style: GoogleFonts.inter(
                    color: Color.fromARGB(255, 147, 158, 170),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Amount and payment method
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isDebit ? "-" : "+"}₹ 100',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDebit
                      ? const Color.fromARGB(255, 255, 43, 43)
                      : const Color.fromARGB(255, 65, 184, 119),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Credit Card',
                style: GoogleFonts.inter(
                  color: Color.fromARGB(255, 103, 103, 103),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
