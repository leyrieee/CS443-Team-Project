import 'package:flutter/material.dart';
import 'event_details.dart';

class EventFeedPage extends StatelessWidget {
  const EventFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy event data for now
    final List<Map<String, String>> events = [
      {
        'title': 'Community Clean-Up',
        'date': 'April 10, 2025',
        'location': 'Accra',
        'image': 'https://via.placeholder.com/400x200'
      },
      {
        'title': 'Tech Skills Training',
        'date': 'April 12, 2025',
        'location': 'Kumasi',
        'image': 'https://via.placeholder.com/400x200'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Feed'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => EventDetailsPage(event: event),
              ));
            },
            child: Card(
              margin: const EdgeInsets.all(12),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    event['image']!,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event['title']!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('${event['date']} · ${event['location']}',
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
