import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TherapistPaymentScreen extends StatefulWidget {
  const TherapistPaymentScreen({super.key});

  @override
  State<TherapistPaymentScreen> createState() => _TherapistPaymentScreenState();
}

class _TherapistPaymentScreenState extends State<TherapistPaymentScreen> {
  String selectedCenter = 'XYZ Therapy center';
  String selectedPaymentMode = 'UPI';
  TextEditingController amountController = TextEditingController(text: '250');
  final List<String> patientName = ['ankit', 'rudra', 'nehal'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Record Patient Payment',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color.fromARGB(255, 24, 8, 41),
          ),
        ),
        actions: [
          Container(
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient Name',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 135, 141, 186),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 46, 44, 52),
              ),
              icon: Icon(Icons.keyboard_arrow_down),
              borderRadius: BorderRadius.circular(8),
              iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
              iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
              dropdownColor: const Color.fromARGB(255, 255, 255, 255),
              decoration: InputDecoration(
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
                hintText: 'Select',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 102, 114, 128),
                ),
              ),
              items: patientName
                  .map((String patient) => DropdownMenuItem(
                        value: patient,
                        child: FittedBox(
                          child: Text(
                            patient,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 46, 44, 52),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (String? newValue) {},
            ),
            SizedBox(height: 24),
            Text(
              'Amount',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 135, 141, 186),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 46, 44, 52),
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee),
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
                  return "Please enter your number";
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            Text(
              'Payment Mode',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 135, 141, 186),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedPaymentMode,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 46, 44, 52),
              ),
              icon: Icon(Icons.keyboard_arrow_down),
              borderRadius: BorderRadius.circular(8),
              iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
              iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
              dropdownColor: Color.fromARGB(255, 255, 255, 255),
              decoration: InputDecoration(
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
                hintText: 'Select',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 102, 114, 128),
                ),
              ),
              items: ['UPI', 'Cash']
                  .map(
                    (role) => DropdownMenuItem(
                      value: role,
                      child: FittedBox(
                        child: Text(
                          role,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 46, 44, 52),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {},
            ),
          ],
        ),
      ),
    );
  }
}
