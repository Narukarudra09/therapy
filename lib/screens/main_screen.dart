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
import 'package:therapy/screens/therapist_screen/therapist_daily_data_screen.dart';
import 'package:therapy/screens/therapist_screen/therapist_patient_screen.dart';
import 'package:therapy/screens/therapist_screen/therapist_payment_screen.dart';
import 'package:therapy/screens/therapist_screen/therapist_settings_screen.dart';

import '../models/user_role.dart';
import '../providers/auth_provider.dart';
import '../providers/navigation_provider.dart';
import 'center_owner_screens/center_daily_data_screen.dart';
import 'center_owner_screens/center_patient_screen.dart';
import 'center_owner_screens/center_payment_screen.dart';
import 'center_owner_screens/center_settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final navProvider = Provider.of<NavigationProvider>(context);

    if (authProvider.selectedUser == null) {
      return Scaffold(
        body: Center(
          child: Text('User not selected. Please log in.'),
        ),
      );
    }

    UserModel user =
        authProvider.selectedUser! as UserModel; // Get the UserModel

    return Scaffold(
      body: _buildDashboardForRole(
        context,
        user.userType, // Use userType from UserModel
        navProvider.currentIndex,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(
        context,
        user.userType, // Use userType from UserModel
        navProvider.currentIndex,
      ),
    );
  }

  Widget _buildDashboardForRole(
      BuildContext context, String role, int currentIndex) {
    switch (role) {
      case 'Super Admin':
        return [
          SuperPatientScreen(),
          SuperTherapistsScreen(),
          SuperPaymentsScreen(),
          SuperCentersScreen()
        ][currentIndex];
      case 'Center Owner':
        return [
          CenterDailyDataScreen(),
          CenterPatientScreen(),
          CenterPaymentScreen(),
          CenterSettingsScreen()
        ][currentIndex];
      case 'Therapist':
        return [
          TherapistDailyDataScreen(),
          TherapistPatientScreen(),
          TherapistPaymentScreen(),
          TherapistSettingsScreen()
        ][currentIndex];
      case 'Patient':
        return [
          PatientHomeScreen(patientName: ''),
          PatientTherapiesScreen(patientName: ''),
          PatientPaymentScreen(patientName: ''),
          PatientSettingsScreen(patientName: '')
        ][currentIndex];
      default:
        return Center(child: Text('Invalid user role'));
    }
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, String role, int currentIndex) {
    final navController = Provider.of<NavigationProvider>(context);

    List<BottomNavigationBarItem> getNavItems(String role) {
      switch (role) {
        case 'Super Admin':
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
        case 'Center Owner':
        case 'Therapist':
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
        case 'Patient':
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
        default:
          return [];
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
      onTap: (index) => navController.updateIndex(index),
      items: getNavItems(role),
    );
  }
}
