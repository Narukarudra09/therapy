import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_save_screen.dart';
import '../../providers/patient_provider.dart';

class NewPhoneNumber extends StatefulWidget {
  final String verifiedPhoneNumber;

  const NewPhoneNumber({
    super.key,
    required this.verifiedPhoneNumber,
  });

  @override
  State<NewPhoneNumber> createState() => _NewPhoneNumberState();
}

class _NewPhoneNumberState extends State<NewPhoneNumber> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.verifiedPhoneNumber;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveNewPhoneNumber() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a new phone number')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final provider = Provider.of<PatientProvider>(context, listen: false);
      await provider.updatePhoneNumber(_phoneController.text);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SuccessScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
        scrolledUnderElevation: 0,
        title: Text(
          'Verify Phone Number',
          style: GoogleFonts.inter(
            color: Color(0xFF171C22),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'New Phone Number',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Color(0xFF878DBA),
                  ),
                ),
                Text(
                  '*',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Color(0xFFFF2B2B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
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
            ),
            const SizedBox(height: 52),
            CustomButton(
              title: _isLoading ? "Saving..." : "Save",
              onTap: _saveNewPhoneNumber,
            ),
          ],
        ),
      ),
    );
  }
}
