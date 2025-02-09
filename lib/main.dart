import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapy/screens/auth/splash_screen.dart';
import 'package:therapy/state_controllers/auth_controller.dart';
import 'package:therapy/state_controllers/navigation_controller.dart';
import 'package:therapy/state_controllers/super_center_controller.dart';
import 'package:therapy/state_controllers/super_patient_controller.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Therapy App',
      home: SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(NavigationController());
        Get.put(SuperPatientController());
        Get.put(SuperCenterController());
      }),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 5,
          scrolledUnderElevation: 5,
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          hourMinuteTextColor: Color(0xFF21005D),
          hourMinuteColor: Color(0xFFEBF6ED),
          dayPeriodTextColor: Color(0xFF31111D),
          dayPeriodColor: Color(0xFFEBF6ED),
          dialHandColor: Color(0xFF41B877),
          dialBackgroundColor: Color(0xFFE9E9E9),
          dialTextColor: Color(0xFF1D1B20),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF41B877),
          selectionColor: Color(0xFF41B877),
          selectionHandleColor: Color(0xFF41B877),
        ),
      ),
    );
  }
}
