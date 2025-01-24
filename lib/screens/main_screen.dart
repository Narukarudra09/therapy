import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapy/screens/patient_screen/patient_home_screen.dart';
import 'package:therapy/screens/patient_screen/patient_payment_screen.dart';
import 'package:therapy/screens/patient_screen/patient_settings_screen.dart';
import 'package:therapy/screens/patient_screen/patient_therapies_screen.dart';
import 'package:therapy/screens/super_admin_screens/super_centers_screen.dart';
import 'package:therapy/screens/super_admin_screens/super_patient_screen.dart';
import 'package:therapy/screens/super_admin_screens/super_payment_screen.dart';
import 'package:therapy/screens/super_admin_screens/super_therapist_screen.dart';

import '../models/user_profile.dart';
import '../providers/auth_provider.dart';
import '../providers/navigation_provider.dart';
import 'center_owner_screens/center_daily_data_screen.dart';
import 'center_owner_screens/center_patient_screen.dart';
import 'center_owner_screens/center_payment_screen.dart';
import 'center_owner_screens/center_settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Consumer<NavigationProvider>(
        builder: (context, navProvider, child) {
          return _buildDashboardForRole(context,
              authProvider.selectedUser!.role, navProvider.currentIndex);
        },
      ),
      bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, navProvider, child) {
          return _buildBottomNavigationBar(context,
              authProvider.selectedUser!.role, navProvider.currentIndex);
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
          PatientHomeScreen(),
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
                icon: Icon(Icons.people), label: 'Patients'),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_services), label: 'Therapists'),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment), label: 'Payments'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_city), label: 'Centers'),
          ];
        case UserRole.centerOwner:
        case UserRole.therapist:
          return [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Daily Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: 'Patients'),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment), label: 'Payments'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ];
        case UserRole.patient:
          return [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_services), label: 'Therapies'),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment), label: 'Payments'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ];
      }
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => navProvider.updateIndex(index),
      items: getNavItems(role),
    );
  }
}
