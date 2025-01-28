import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/auth_provider.dart';
import 'package:therapy/providers/navigation_provider.dart';
import 'package:therapy/providers/super_patient_provider.dart';
import 'package:therapy/screens/auth/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => SuperPatientProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Therapy App',
      home: SplashScreen(),
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
      ),
    );
  }
}
