import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/screens/patient_screen/blood_group.dart';
import 'package:therapy/widgets/patients/add_allergies.dart';

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  String bloodGroup = 'A+';
  List<String> allergies = ['Cheese', 'Cheese', 'Cheese'];
  final List<Map<String, dynamic>> medicalRecords = [
    {'title': 'alergic khasi', 'date': '12-05-2023 • 12:00 am'},
    {'title': 'alergic khasi', 'date': '12-05-2023 • 12:00 am'},
    {'title': 'alergic khasi', 'date': '12-05-2023 • 12:00 am'},
  ];
  final List<Map<String, dynamic>> prescriptions = [
    {'title': 'alergic khasi', 'date': '12-05-2023 • 12:00 am', 'isPdf': false},
    {'title': 'alergic khasi', 'date': '12-05-2023 • 12:00 am', 'isPdf': false},
    {'title': 'alergic khasi', 'date': '12-05-2023 • 12:00 am', 'isPdf': true},
  ];

  void _deleteAllergy(String allergy) {
    setState(() {
      allergies.remove(allergy);
    });
  }

  void _updateBloodGroup(String newBloodGroup) {
    setState(() {
      bloodGroup = newBloodGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Medical History',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () {},
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
              'Blood Group',
              ListTile(
                title: Text(
                  bloodGroup,
                  style: const TextStyle(fontSize: 18),
                ),
              ), onTap: () async {
            final newBloodGroup = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BloodGroup(),
              ),
            );
            if (newBloodGroup != null) {
              _updateBloodGroup(newBloodGroup);
            }
          }),
          const SizedBox(height: 16),
          _buildSection(
              'Allergies',
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  children: allergies
                      .map((allergy) => Chip(
                            label: Text(allergy),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () {
                              _deleteAllergy(allergy);
                            },
                            backgroundColor: Colors.grey[200],
                          ))
                      .toList(),
                ),
              ), onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAllergies(),
              ),
            );
          }),
          const SizedBox(height: 16),
          _buildSection(
            'Medical Records',
            Column(
              children: medicalRecords
                  .map((record) => _buildRecordItem(
                        record['title'],
                        record['date'],
                        Icons.medical_services,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Past Prescriptions',
            Column(
              children: prescriptions
                  .map((prescription) => _buildRecordItem(
                        prescription['title'],
                        prescription['date'],
                        prescription['isPdf']
                            ? Icons.picture_as_pdf
                            : Icons.medical_services,
                        iconColor: prescription['isPdf'] ? Colors.red : null,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content, {void Function()? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        border: Border.all(
          color: Color(0xFFE8E9F1),
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.add,
                    color: const Color(0xFF6750A4),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          content,
        ],
      ),
    );
  }

  Widget _buildRecordItem(String title, String date, IconData icon,
      {Color? iconColor}) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      subtitle: Text(date),
      trailing: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {},
      ),
    );
  }
}
