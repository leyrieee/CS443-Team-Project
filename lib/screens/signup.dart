import "package:flutter/material.dart";
import "../widgets.dart";
import "cause_skills.dart";

class SignUpVolunteerPage extends StatelessWidget {
  const SignUpVolunteerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          // Prevents overflow
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
              const SizedBox(height: 20),
              const Text(
                'Turn your skills into something more with Catchafire. Sign up now.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'GT Ultra',
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),

              // New Fields
              buildTextField('Full Name'),
              const SizedBox(height: 5),
              buildTextField('Email'),
              const SizedBox(height: 5),
              buildTextField('Phone Number'),
              const SizedBox(height: 5),
              buildTextField('City/Location'),
              const SizedBox(height: 5),
              buildTextField('Password', obscureText: true),
              const SizedBox(height: 5),
              buildTextField('Confirm Password', obscureText: true),

              const SizedBox(height: 20),
              buildPrimaryButton('Sign Up', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CauseAndSkillsPage()),
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
}
