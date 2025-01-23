import 'package:flutter/material.dart';

class CustomNavigation extends StatelessWidget {
  final String role;

  const CustomNavigation({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navigationItems;

    switch (role) {
      case 'super admin':
        navigationItems = [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Patients'),
          BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety), label: 'Therapist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Payments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Center'),
        ];
        break;
      case 'center owner':
        navigationItems = [
          BottomNavigationBarItem(
              icon: Icon(Icons.folder), label: 'Daily Data'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Patients'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Payments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ];
        break;
      case 'therapist':
        navigationItems = [
          BottomNavigationBarItem(
              icon: Icon(Icons.folder), label: 'Daily Data'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Patients'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Payments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ];
        break;
      case 'patient':
        navigationItems = [
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Therapies'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Payments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ];
        break;
      default:
        navigationItems = [];
    }

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Welcome, $role')),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: Colors.green,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
        ),
        selectedItemColor: Colors.green,
        // Active color
        unselectedItemColor: Colors.grey,
        // Inactive color
        items: navigationItems,
      ),
    );
  }
}
