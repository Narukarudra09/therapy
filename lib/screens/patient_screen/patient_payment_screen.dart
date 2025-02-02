import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientPaymentScreen extends StatelessWidget {
  const PatientPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDebit = false;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.center,
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
              "Welcom",
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
            backgroundImage: AssetImage("assets/profile.png"),
          )),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 20, right: 20),
        child: SingleChildScrollView(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
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
                    // Name and date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gardens Galleria Par",
                            style: GoogleFonts.inter(
                              color: Color.fromARGB(255, 8, 12, 62),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '11:00 AM & 23 Apr 2021',
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
