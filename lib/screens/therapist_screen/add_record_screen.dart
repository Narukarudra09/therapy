import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/therapist_provider.dart';
import 'dart:async';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _givenByController = TextEditingController();
  Timer? _debounce;

  final List<String> therapies = [
    'Manual Therapy',
    'Exercise Therapy',
    'Electrotherapy',
    'Therapeutic Ultrasound',
    'Neuromuscular Electrical Stimulation',
    'Interferential Current Therapy',
    'Ultrasound Therapy',
    'Heat Therapy',
    'Cold Therapy',
    'Light Therapy',
    'Sound Therapy',
    'Hydrotherapy',
  ];

  @override
  void initState() {
    super.initState();
    _initializeTherapistName();
    Provider.of<TherapistProvider>(context, listen: false).clearSearchResults();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _patientNameController.dispose();
    _givenByController.dispose();
    super.dispose();
  }

  void _initializeTherapistName() {
    final therapistProvider =
        Provider.of<TherapistProvider>(context, listen: false);
    if (therapistProvider.therapist?.name != null) {
      _givenByController.text = therapistProvider.therapist!.name!;
    }
  }

  void _showTherapySelectionDialog() {
    final therapistProvider =
        Provider.of<TherapistProvider>(context, listen: false);
    List<String> selectedTherapiesCopy =
        List.from(therapistProvider.selectedTherapies);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text('Select Therapies'),
          titleTextStyle: GoogleFonts.poppins(
            color: Color(0xFF171C22),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          content: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: therapies.map((therapy) {
                      return CheckboxListTile(
                        title: Text(therapy),
                        value: selectedTherapiesCopy.contains(therapy),
                        onChanged: (bool? value) {
                          if (value != null) {
                            setDialogState(() {
                              if (value) {
                                selectedTherapiesCopy.add(therapy);
                              } else {
                                selectedTherapiesCopy.remove(therapy);
                              }
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                therapistProvider
                    .updateSelectedTherapies(selectedTherapiesCopy);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveRecord() {
    final therapistProvider =
        Provider.of<TherapistProvider>(context, listen: false);

    if (therapistProvider.selectedPatientPhone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please select a valid patient from the search results'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> recordData = {
        'patientName': therapistProvider.selectedPatientName,
        'patientPhone': therapistProvider.selectedPatientPhone,
        'therapyTypes': therapistProvider.selectedTherapies,
        'date': therapistProvider.selectedDate,
        'time': therapistProvider.selectedTime.format(context),
        'givenBy': _givenByController.text,
        'therapistId': therapistProvider.therapist?.phoneNumber,
        'timestamp': DateTime.now(),
      };

      therapistProvider.addRecord(recordData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TherapistProvider>(
      builder: (context, therapistProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add Record"),
            titleTextStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 23, 28, 34),
            ),
            elevation: 0,
            scrolledUnderElevation: 0,
            shape: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3)),
            actions: [
              InkWell(
                onTap: _saveRecord,
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
          body: Padding(
            padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patient Full Name',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 135, 141, 186),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _patientNameController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          if (mounted) {
                            therapistProvider.searchPatients(value);
                          }
                        });
                      },
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 46, 44, 52),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type at least 2 characters to search',
                        prefixIcon: Icon(Icons.search),
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
                        if (value == null || value.isEmpty) {
                          return "Please enter the patient's name";
                        }
                        if (therapistProvider.selectedPatientPhone == null) {
                          return "Please select a patient from the search results";
                        }
                        return null;
                      },
                    ),
                    if (therapistProvider.searchResults.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        constraints: BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 232, 233, 241)),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: therapistProvider.searchResults.length,
                          itemBuilder: (context, index) {
                            final patient =
                                therapistProvider.searchResults[index];
                            return ListTile(
                              leading: Icon(Icons.person_outline,
                                  color: Colors.grey),
                              title: Text(patient['name']),
                              onTap: () {
                                _patientNameController.text = patient['name'];
                                therapistProvider.updateSelectedPatient(
                                  patient['name'],
                                  patient['phone'],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Type Of Therapy',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 135, 141, 186),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _showTherapySelectionDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 232, 233, 241)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                therapistProvider.selectedTherapies.isEmpty
                                    ? "Select"
                                    : therapistProvider.selectedTherapies
                                        .join(", "),
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 46, 44, 52),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Color(0xFF171C22),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      children:
                          therapistProvider.selectedTherapies.map((therapy) {
                        return Chip(
                          deleteIcon: Icon(Icons.close),
                          color: WidgetStateProperty.all(Color(0xFFE9E9E9)),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(0),
                          labelPadding: EdgeInsets.symmetric(horizontal: 8),
                          label: Text(therapy),
                          labelStyle: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2E2C34)),
                          onDeleted: () =>
                              therapistProvider.removeTherapy(therapy),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: therapistProvider.selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                therapistProvider.updateSelectedDate(picked);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 13),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 232, 233, 241)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${therapistProvider.selectedDate.toLocal()}"
                                          .split(' ')[0],
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                            255, 46, 44, 52),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Color(0xFF171C22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: therapistProvider.selectedTime,
                              );
                              if (picked != null) {
                                therapistProvider.updateSelectedTime(picked);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 13),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 232, 233, 241)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    therapistProvider.selectedTime
                                        .format(context),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromARGB(255, 46, 44, 52),
                                    ),
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    size: 18,
                                    color: Color(0xFF171C22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Given By',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 135, 141, 186),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _givenByController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Therapist name is required";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
