import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/super_center_provider.dart';
import 'package:therapy/widgets/therapist/add_therapist.dart';

import '../../models/therapist.dart';
import '../../widgets/custom_add_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_listtile.dart';
import '../../widgets/therapist/therapist_profile.dart';

class SuperTherapistsScreen extends StatelessWidget {
  const SuperTherapistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: '',
      ),
      body: Consumer<SuperCenterProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Center Member",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 24, 8, 41),
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      CustomAddButton(
                        title: "Add Center Member",
                        onTap: () async {
                          final newTherapist = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTherapist(),
                            ),
                          ) as Therapist?;
                          if (newTherapist != null) {
                            provider.addTherapist(newTherapist);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.therapists.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final therapist = provider.therapists[index];
                      return CustomListTile(
                        title: therapist.name,
                        subtitle: therapist.role,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TherapistProfile(
                                therapistName: therapist.name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
