import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  String title;
  final VoidCallback onTap;

  CustomButton({super.key, required this.title, required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 65, 184, 119),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 255, 243, 237),
            ),
          ),
        ),
      ),
    );
  }
}
