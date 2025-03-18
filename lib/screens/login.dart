import "package:flutter/material.dart";
import "../widgets.dart";
import 'signup_organisation.dart';
import 'signup_volunteer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              'Welcome Back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'GT Ultra',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Log into your account',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GT Ultra',
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            buildTextField('Email'),
            const SizedBox(height: 10),
            buildTextField('Password', obscureText: true),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {}, //define later
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 10),
            buildPrimaryButton('Login', () {}), // Login button
            const SizedBox(height: 20),

            // Sign-Up Options
            const Center(
              child: Text("New to Catchafire? Sign up as:",
                  style: TextStyle(fontFamily: "GT Ultra", fontSize: 12)),
            ),
            const SizedBox(height: 5),

            // Sign-Up Buttons in Row
            Row(
              children: [
                Expanded(
                  child: buildSecondaryButton(
                    'Volunteer',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpVolunteerPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons
                Expanded(
                  child: buildSecondaryButton(
                    'Organization',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpOrganisationPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
