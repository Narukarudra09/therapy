import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_button.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _uploadedFileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _uploadedFileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report a Problem"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Reason/issue',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                Text(
                  "*",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 255, 43, 43),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: 'Performance Issues',
              icon: Icon(Icons.keyboard_arrow_down_outlined),
              iconEnabledColor: const Color(0xFF171C22),
              iconDisabledColor: const Color(0xFF171C22),
              dropdownColor: const Color.fromARGB(255, 243, 243, 253),
              decoration: InputDecoration(
                hintText: "Select",
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2E2C34),
                ),
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
              items: [
                'App Crashes',
                'Performance Issues',
                'Bugs and Glitches',
                'UI/UX Issues',
                'Functionality Issues',
                'Compatibility Issues',
                'Data Issues',
                'Login/Authentication Issues',
                'Accessibility Issues',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: FittedBox(child: Text(value)),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  'Message',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                Text(
                  "*",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 255, 43, 43),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: TextFormField(
                maxLines: 6,
                controller: controller,
                keyboardType: TextInputType.text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 46, 44, 52),
                ),
                decoration: InputDecoration(
                  hintText: "Write here",
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2E2C34),
                  ),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your message";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  'Upload Issue',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                Text(
                  "*",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 255, 43, 43),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                _pickFile();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 232, 233, 241),
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _uploadedFileName != null
                        ? Text(
                            _uploadedFileName!,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF2E2C34),
                            ),
                          )
                        : Text(
                            'Upload',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF2E2C34),
                            ),
                          ),
                    Icon(
                      Icons.upload_file_outlined,
                      color: Color(0xFF95A0AC),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            CustomButton(title: "Submit", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
