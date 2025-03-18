import "package:flutter/material.dart";
import "../widgets.dart";

class SignUpOrganisationPage extends StatelessWidget {
  const SignUpOrganisationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
              'Bridging paths to stronger communities',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'GT Ultra',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Start your philanthropy journey right. Easily create and track volunteer opportunities with immediate impact.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GT Ultra',
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // Organization Name
            buildTextField('Organization Name'),

            const SizedBox(height: 10),

            // Email
            buildTextField('Email'),

            const SizedBox(height: 10),

            // Phone Number (Regular TextField for now)
            buildTextField('Phone Number'),

            const SizedBox(height: 10),

            // Location (City, Country)
            buildTextField('City'),
            const SizedBox(height: 10),
            buildTextField('Country'),

            const SizedBox(height: 10),

            // Organization Type Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Organization Type',
                border: OutlineInputBorder(),
              ),
              items: [
                'NGO',
                'Non-Profit',
                'Social Enterprise',
                'Charity',
                'Other',
              ].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            const SizedBox(height: 10),

            // Website (Optional)
            buildTextField('Website (Optional)'),

            const SizedBox(height: 10),

            // Mission Statement
            buildTextField('Mission Statement'),

            const SizedBox(height: 20),

            // Password & Confirm Password
            buildTextField('Password', obscureText: true),
            const SizedBox(height: 10),
            buildTextField('Confirm Password', obscureText: true),

            const SizedBox(height: 20),

            // Sign Up Button
            buildPrimaryButton('Sign Up', () {}),

            const SizedBox(height: 10),

            // Already have an account? Login
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
    );
  }
}
