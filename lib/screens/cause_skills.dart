import 'package:flutter/material.dart';

class CauseAndSkillsPage extends StatelessWidget {
  const CauseAndSkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Cause & Skills',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Causes You Care About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _buildChips([
                'Education', 'Environment', 'Science & Technology', 'Health', 'Childcare'
              ]),
            ),
            const SizedBox(height: 20),
            const Text(
              'Skills You Can Offer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _buildChips([
                'Graphic Design', 'Fundraising', 'Training', 'Event Planning', 'Communications'
              ]),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: const Text('Save & Continue',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChips(List<String> items) {
    return items
        .map((item) => Chip(
              label: Text(item),
              backgroundColor: Colors.blue.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ))
        .toList();
  }
}
