import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

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
