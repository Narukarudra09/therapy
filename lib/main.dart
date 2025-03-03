import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/firebase_options.dart';
import 'package:therapy/providers/auth_provider.dart';
import 'package:therapy/providers/navigation_provider.dart';
import 'package:therapy/providers/patient_provider.dart';
import 'package:therapy/providers/super_center_provider.dart';
import 'package:therapy/providers/super_patient_provider.dart';
import 'package:therapy/screens/auth/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => SuperPatientProvider()),
        ChangeNotifierProvider(create: (_) => SuperCenterProvider()),
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
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Color(0xFF40B777)),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.roboto(
                color: Color(0xFF40B777),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.43,
                letterSpacing: 0.10,
              ),
            ),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Color(0xFF40B777)),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.roboto(
                color: Color(0xFF40B777),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.43,
                letterSpacing: 0.10,
              ),
            ),
          ),
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
