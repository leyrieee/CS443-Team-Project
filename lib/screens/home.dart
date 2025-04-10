import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom header without the back button
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo at the top left corner
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width *
                          0.3, // Adjust logo size
                    ),
                  ),
                  // Home text in the center (no app bar)
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  // Welcome section that moves with scroll
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello, Maya!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Find volunteer opportunities that match your skills',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Event cards
                  _buildEventCard(
                    image: 'assets/community_garden.jpg',
                    title: 'Community Garden Cleanup',
                    organization: 'Green City Initiative',
                    location: 'Central Park, NY',
                    date: 'April 15, 2025',
                    skills: ['Gardening', 'Physical labor'],
                    backgroundColor: Colors.green[50]!,
                  ),
                  _buildEventCard(
                    image: 'assets/teach_coding.jpg',
                    title: 'Teach Coding to Kids',
                    organization: 'Tech for All',
                    location: 'Downtown Library',
                    date: 'April 18, 2025',
                    skills: ['Programming', 'Teaching'],
                    backgroundColor: Colors.blue[50]!,
                  ),
                  _buildEventCard(
                    image: 'assets/food_drive.jpg',
                    title: 'Food Drive Volunteers',
                    organization: 'Food for Families',
                    location: 'Community Center',
                    date: 'April 22, 2025',
                    skills: ['Organization', 'Communication'],
                    backgroundColor: Colors.orange[50]!,
                  ),
                  _buildEventCard(
                    image: 'assets/elderly_care.jpg',
                    title: 'Elderly Care Assistance',
                    organization: 'Golden Years Foundation',
                    location: 'Sunset Homes',
                    date: 'April 25, 2025',
                    skills: ['Healthcare', 'Compassion'],
                    backgroundColor: Colors.purple[50]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle post event action
        },
        backgroundColor: Colors.orange[700],
        elevation: 2,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add), // This will be hidden by FAB
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String image,
    required String title,
    required String organization,
    required String location,
    required String date,
    required List<String> skills,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to the event details page or show a dialog
        // You can replace this with your desired navigation action
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(eventTitle: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image with rounded corners on top
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Event details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    organization,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills
                        .map((skill) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Text(
                                skill,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample Event Detail Page (You can modify this as needed)
class EventDetailPage extends StatelessWidget {
  final String eventTitle;

  const EventDetailPage({super.key, required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(eventTitle)),
      body: Center(
        child: Text('More details about $eventTitle'),
      ),
    );
  }
}
