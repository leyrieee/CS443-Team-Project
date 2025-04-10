import "package:flutter/material.dart";
import 'cause_skills.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 242, 230, 1),
      body: SingleChildScrollView(
        // Make the body scrollable
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Ready to change the world, Volunteer?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'GT Ultra',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Create an account to get started',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // New Fields
              buildTextField('Full Name'),
              const SizedBox(height: 10),
              buildTextField('Email'),
              const SizedBox(height: 10),
              buildTextField('Phone Number'),
              const SizedBox(height: 10),
              buildTextField('City/Location'),
              const SizedBox(height: 10),
              buildTextField('Password', obscureText: true),
              const SizedBox(height: 10),
              buildTextField('Confirm Password', obscureText: true),

              const SizedBox(height: 20),
              buildPrimaryButton('Sign Up', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CauseAndSkillsPage()),
                );
              }),

              const SizedBox(height: 20),

              // Log-in Option with Clickable "Log in" Link
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontFamily: "GT Ultra", fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontFamily: "GT Ultra",
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color.fromRGBO(41, 37, 37, 1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(200, 196, 180, 1),
      ),
    );
  }

  Widget buildPrimaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Color(0xFF6FE6FF)),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildSecondaryButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
