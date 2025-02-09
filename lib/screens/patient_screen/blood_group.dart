import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BloodGroup extends StatefulWidget {
  const BloodGroup({super.key});

  @override
  State<BloodGroup> createState() => _BloodGroupState();
}

class _BloodGroupState extends State<BloodGroup> {
  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedBloodGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
        scrolledUnderElevation: 0,
        title: Text("Blood Group"),
        titleTextStyle: GoogleFonts.inter(
          color: Color(0xFF171C22),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          InkWell(
            onTap: () {
              if (selectedBloodGroup != null) {
                Navigator.pop(context, selectedBloodGroup);
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 65, 184, 119),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    // Adjust max width as needed
                    child: Text(
                      "Save",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 16, left: 20, right: 20),
        itemCount: bloodGroups.length,
        itemBuilder: (context, index) {
          return RadioListTile<String>(
            title: Text(bloodGroups[index]),
            value: bloodGroups[index],
            groupValue: selectedBloodGroup,
            activeColor: Color.fromARGB(255, 65, 184, 119),
            onChanged: (String? value) {
              setState(() {
                selectedBloodGroup = value;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
          );
        },
      ),
    );
  }
}
