import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAddButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final MainAxisAlignment mainAxisAlignment;

  const CustomAddButton(
      {super.key,
      required this.title,
      this.onTap,
      this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        spacing: 4,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(4)),
            child: Center(
              child: Icon(
                Icons.add,
                color: Color.fromARGB(255, 73, 13, 140),
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 73, 13, 140),
            ),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
