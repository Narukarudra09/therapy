import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report a Problem"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              'City',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color.fromARGB(255, 135, 141, 186),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: 'Bhilwara',
              icon: Icon(Icons.keyboard_arrow_down_outlined),
              iconEnabledColor: const Color(0xFF171C22),
              iconDisabledColor: const Color(0xFF171C22),
              dropdownColor: const Color.fromARGB(255, 243, 243, 253),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 232, 233, 241),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 232, 233, 241),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 232, 233, 241),
                  ),
                ),
              ),
              items: ['Bhilwara', 'Jaipur'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
