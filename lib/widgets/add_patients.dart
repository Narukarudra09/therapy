import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPatients extends StatefulWidget {
  const AddPatients({super.key});

  @override
  State<AddPatients> createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  String _city = 'Super Admin';
  String _bloodGroup = 'A+';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Patients"),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 23, 28, 34),
        ),
        actions: [
          Container(
            width: 74,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(255, 65, 184, 119),
            ),
            child: Center(
              child: Text(
                "Save",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Basic Profile",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 23, 28, 34),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    "Mobile Number",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
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
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2E2C34),
                  ),
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your number";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Full Name",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              const SizedBox(height: 8),
              Form(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E2C34),
                  ),
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
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "City",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                borderRadius: BorderRadius.circular(8),
                iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                dropdownColor: const Color.fromARGB(255, 243, 243, 253),
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
                ),
                items: ['Bhilwara']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(
                            role,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2E2C34),
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _city = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                "Medical Profile",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 23, 28, 34),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Blood Group",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                borderRadius: BorderRadius.circular(8),
                iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                dropdownColor: const Color.fromARGB(255, 243, 243, 253),
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
                ),
                items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(
                            role,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2E2C34),
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      _bloodGroup = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 250, 250, 250),
                    border: Border.all(
                      color: Color.fromARGB(255, 232, 233, 241),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Allergies",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 46, 44, 52),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 73, 13, 140),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 250, 250, 250),
                    border: Border.all(
                      color: Color.fromARGB(255, 232, 233, 241),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Medical Records",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 46, 44, 52),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 73, 13, 140),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 250, 250, 250),
                    border: Border.all(
                      color: Color.fromARGB(255, 232, 233, 241),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Past Prescriptions",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 46, 44, 52),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 73, 13, 140),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
