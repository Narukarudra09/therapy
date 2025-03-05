import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/widgets/custom_add_button.dart';
import '../../providers/patient_provider.dart';

class AddAllergies extends StatelessWidget {
  const AddAllergies({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(
        () => context.read<PatientProvider>().loadExistingAllergies());

    return Consumer<PatientProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Allergies',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            actions: [
              InkWell(
                onTap: () async {
                  try {
                    await provider.saveSelectedAllergies();
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to save allergies: $e')),
                    );
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
              ),
            ],
          ),
          body: ListView(
            children: [
              // Add New Button
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Add New',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: provider.newAllergyController,
                              decoration: InputDecoration(
                                hintText: 'Write Here',
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'No',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (provider.newAllergyController.text
                                        .trim()
                                        .isNotEmpty) {
                                      provider.addNewAllergy(
                                        provider.newAllergyController.text,
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4CAF50),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 48,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: Text(
                                    'Add',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomAddButton(
                      title: "Add New",
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
              ),
              // Allergies List
              ...provider.predefinedAllergies
                  .map((allergy) => ListTile(
                        title: Text(
                          allergy,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Color(0xFF2E2C34),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () => provider.toggleAllergy(allergy),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    provider.selectedAllergies.contains(allergy)
                                        ? const Color(0xFF4CAF50)
                                        : Colors.grey.shade300,
                              ),
                              color:
                                  provider.selectedAllergies.contains(allergy)
                                      ? const Color(0xFF4CAF50)
                                      : Colors.white,
                            ),
                            child: provider.selectedAllergies.contains(allergy)
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        );
      },
    );
  }
}
