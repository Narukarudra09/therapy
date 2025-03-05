import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/patient_provider.dart';

class AddAllergies extends StatelessWidget {
  const AddAllergies({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            shape: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
            ),
            scrolledUnderElevation: 0,
            title: Text(
              'Add Allergies',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF171C22),
              ),
            ),
            actions: [
              InkWell(
                onTap: () async {
                  if (provider.selectedAllergies.isNotEmpty) {
                    try {
                      await provider.saveSelectedAllergies();
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to save allergies: $e')),
                      );
                    }
                  } else {
                    Navigator.pop(context);
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Select your allergies',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: provider.predefinedAllergies.length,
                  itemBuilder: (context, index) {
                    final allergy = provider.predefinedAllergies[index];
                    final isSelected =
                        provider.selectedAllergies.contains(allergy);

                    return InkWell(
                      onTap: () => provider.toggleAllergy(allergy),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? Color(0xFF6750A4)
                                : Color(0xFFE8E9F1),
                          ),
                          color: isSelected
                              ? Color(0xFF6750A4).withOpacity(0.1)
                              : Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSelected)
                              Icon(
                                Icons.check,
                                size: 16,
                                color: Color(0xFF6750A4),
                              ),
                            if (isSelected) SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                allergy,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: isSelected
                                      ? Color(0xFF6750A4)
                                      : Color(0xFF2E2C34),
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (provider.selectedAllergies.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Allergies:',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: provider.selectedAllergies
                            .map((allergy) => Chip(
                                  label: Text(allergy),
                                  deleteIcon: Icon(Icons.close, size: 18),
                                  onDeleted: () =>
                                      provider.removeSelectedAllergy(allergy),
                                  backgroundColor: Color(0xFFF5F5F5),
                                  side: BorderSide.none,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
