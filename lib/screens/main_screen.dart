import 'package:flutter/material.dart';
import 'package:therapy/widgets/custom_navigation.dart';

class MainScreen extends StatefulWidget {
  final String role;

  const MainScreen({super.key, required this.role});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          CustomNavigation(role: widget.role, onItemTapped: _onItemTapped),
    );
  }
}
