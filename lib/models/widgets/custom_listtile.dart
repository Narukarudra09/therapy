import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final Color? avatarBackgroundColor;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.avatarBackgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: ListTile(
        tileColor: Colors.white,
        minLeadingWidth: 30,
        horizontalTitleGap: 12,
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: avatarBackgroundColor ?? Colors.grey.shade200,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          child: imageUrl == null
              ? Text(title[0].toUpperCase(),
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 8, 12, 62)))
              : null,
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 8, 12, 62)),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 135, 141, 186),
          ),
        ),
        onTap: onTap,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color.fromARGB(255, 235, 246, 237))),
      ),
    );
  }
}
