import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/screens/patient_screen/patient_home_screen.dart';
import 'package:therapy/screens/patient_screen/patient_payment_screen.dart';
import 'package:therapy/screens/patient_screen/patient_settings_screen.dart';
import 'package:therapy/screens/patient_screen/patient_therapies_screen.dart';
import 'package:therapy/screens/super_admin_screens/super_centers_screen.dart';
import 'package:therapy/screens/super_admin_screens/super_patient_screen.dart';
import 'package:therapy/screens/super_admin_screens/super_payment_screen.dart';
import 'package:therapy/screens/super_admin_screens/super_therapist_screen.dart';

import '../models/user_role.dart';
import '../providers/auth_provider.dart';
import '../providers/navigation_provider.dart';
import 'center_owner_screens/center_daily_data_screen.dart';
import 'center_owner_screens/center_patient_screen.dart';
import 'center_owner_screens/center_payment_screen.dart';
import 'center_owner_screens/center_settings_screen.dart';

class MainScreen extends StatelessWidget {
  final String patientName;

  const MainScreen({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Consumer<NavigationProvider>(
        builder: (context, navProvider, child) {
          return _buildDashboardForRole(
            context,
            authProvider.selectedUser!.role,
            navProvider.currentIndex,
          );
        },
      ),
      bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, navProvider, child) {
          return _buildBottomNavigationBar(
            context,
            authProvider.selectedUser!.role,
            navProvider.currentIndex,
          );
        },
      ),
    );
  }

  Widget _buildDashboardForRole(
      BuildContext context, UserRole role, int currentIndex) {
    switch (role) {
      case UserRole.superAdmin:
        return [
          SuperPatientScreen(),
          SuperTherapistsScreen(),
          SuperPaymentsScreen(),
          SuperCentersScreen()
        ][currentIndex];
      case UserRole.centerOwner:
      case UserRole.therapist:
        return [
          CenterDailyDataScreen(),
          CenterPatientScreen(),
          CenterPaymentScreen(),
          CenterSettingsScreen()
        ][currentIndex];
      case UserRole.patient:
        return [
          PatientHomeScreen(patientName: patientName),
          PatientTherapiesScreen(),
          PatientPaymentScreen(),
          PatientSettingsScreen()
        ][currentIndex];
    }
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, UserRole role, int currentIndex) {
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);

    List<BottomNavigationBarItem> getNavItems(UserRole role) {
      switch (role) {
        case UserRole.superAdmin:
          return [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: 'Patients'),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_services), label: 'Therapists'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long), label: 'Payments'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Centers'),
          ];
        case UserRole.centerOwner:
        case UserRole.therapist:
          return [
            BottomNavigationBarItem(
                icon: Icon(Icons.folder), label: 'Daily Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Patients'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long), label: 'Payments'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ];
        case UserRole.patient:
          return [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Therapies'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long), label: 'Payments'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ];
      }
    }

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 1,
      enableFeedback: false,
      useLegacyColorScheme: false,
      selectedItemColor: Color.fromARGB(255, 65, 184, 119),
      unselectedItemColor: Color.fromARGB(255, 197, 205, 212),
      selectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Color.fromARGB(255, 65, 184, 119)),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => navProvider.updateIndex(index),
      items: getNavItems(role),
    );
  }
}
