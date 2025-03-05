import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/auth_provider.dart';
import 'login_screen.dart';
import 'package:therapy/screens/main_screen.dart';
import 'package:therapy/providers/patient_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkUserAndNavigate();
  }

  Future<void> checkUserAndNavigate() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final patientProvider =
        Provider.of<PatientProvider>(context, listen: false);

    try {
      // First check if user exists
      final userExists = await authProvider.loadFromPrefs();

      if (!mounted) return;

      if (userExists) {
        // If user exists, load patient data and records
        await patientProvider.loadFromPrefs();
        await patientProvider.loadPatientData();
        await patientProvider.loadRecords();

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      print('Error checking user status: $e');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 65, 184, 119),
      body: Stack(
        children: [
          Center(
            child: CustomPaint(
              size: Size.infinite,
              painter: CircularGradientPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/logo.svg"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Therapy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: Text(
                      "A healthier choice for a healthier you",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withOpacity(0.25);

    final circleSizes = [895, 650, 440, 258];
    final strokeWidths = [100.0, 70.0, 60.0, 50.0];

    for (int i = 0; i < circleSizes.length; i++) {
      paint.strokeWidth = strokeWidths[i];
      canvas.drawCircle(center, circleSizes[i] / 2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
