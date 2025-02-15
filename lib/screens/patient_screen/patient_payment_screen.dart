import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_appbar.dart';

class PatientPaymentScreen extends StatefulWidget {
  final String patientName;

  const PatientPaymentScreen({super.key, required this.patientName});

  @override
  State<PatientPaymentScreen> createState() => _PatientPaymentScreenState();
}

class _PatientPaymentScreenState extends State<PatientPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        'isDebit': true,
        'name': 'Gardens Galleria Par',
        'date': '11:00 AM & 23 Apr 2021',
        'amount': 100
      },
      {
        'isDebit': false,
        'name': 'Pharmacy Purchase',
        'date': '02:30 PM & 24 Apr 2021',
        'amount': 150
      },
      {
        'isDebit': true,
        'name': 'Doctor Consultation',
        'date': '09:00 AM & 25 Apr 2021',
        'amount': 200
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        userName: widget.patientName,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 20, right: 20),
        child: SingleChildScrollView(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final isDebit = transaction['isDebit'];
              final name = transaction['name'];
              final date = transaction['date'];
              final amount = transaction['amount'];

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDebit
                            ? const Color(0xFFFFEBEB)
                            : const Color(0xFFE8F5E9),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.inter(
                              color: Color.fromARGB(255, 8, 12, 62),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date,
                            style: GoogleFonts.inter(
                              color: Color.fromARGB(255, 147, 158, 170),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${isDebit ? "-" : "+"}₹ $amount',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDebit
                                ? const Color.fromARGB(255, 255, 43, 43)
                                : const Color.fromARGB(255, 65, 184, 119),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
