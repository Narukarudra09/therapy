import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../state_controllers/auth_controller.dart';
import '../state_controllers/navigation_controller.dart';
import 'center_owner_screens/center_daily_data_screen.dart';
import 'center_owner_screens/center_patient_screen.dart';
import 'center_owner_screens/center_payment_screen.dart';
import 'center_owner_screens/center_settings_screen.dart';

class MainScreen extends StatelessWidget {
  final String patientName;

  const MainScreen({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final navController = Get.find<NavigationController>();

    return Scaffold(
      body: Obx(() {
        return _buildDashboardForRole(
          context,
          authController.selectedUser.value!.role,
          navController.currentIndex.value,
        );
      }),
      bottomNavigationBar: Obx(() {
        return _buildBottomNavigationBar(
          context,
          authController.selectedUser.value!.role,
          navController.currentIndex.value,
        );
      }),
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
        return [
          CenterDailyDataScreen(),
          CenterPatientScreen(),
          CenterPaymentScreen(),
          CenterSettingsScreen()
        ][currentIndex];
      case UserRole.therapist:
        return [
          TherapistDailyDataScreen(),
          TherapistPatientScreen(),
          TherapistPaymentScreen(),
          TherapistSettingsScreen()
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
    final navController = Get.find<NavigationController>();

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
      onTap: (index) => navController.updateIndex(index),
      items: getNavItems(role),
    );
  }
}
