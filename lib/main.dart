import 'package:catchafire/screens/splash_screen.dart';
import 'package:flutter/material.dart';
//import 'screens/cause_skills.dart';

void main() {
  runApp(const CatchafireApp());
}

class CatchafireApp extends StatelessWidget {
  const CatchafireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: const Color.fromRGBO(80, 172, 238, 1),
      ),
      home: const SplashScreen(),
    );
  }
}
