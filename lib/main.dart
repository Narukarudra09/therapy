import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapy/providers/auth_provider.dart';
import 'package:therapy/providers/navigation_provider.dart';
import 'package:therapy/screens/auth/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
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
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}
