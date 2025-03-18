import "package:flutter/material.dart";
import "../widgets.dart";

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
              buildPrimaryButton('Sign Up', () {}),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
