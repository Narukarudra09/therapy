import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            "Welcome",
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
