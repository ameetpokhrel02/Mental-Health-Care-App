import 'package:flutter/material.dart';
import 'package:new_flutter_project/widgets/action_card.dart';
import 'package:new_flutter_project/widgets/app_logo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.all(8.0), child: AppLogo()),
        title: Text('Mental Health Care'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search doctors...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),

          // Quick Actions Grid
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                ActionCard(
                  title: 'Book Appointment',
                  icon: Icons.calendar_today,
                  onTap: () => Navigator.pushNamed(context, '/book-appointment'),
                ),
                ActionCard(
                  title: 'My Appointments',
                  icon: Icons.schedule,
                  onTap: () => Navigator.pushNamed(context, '/appointments'),
                ),
                ActionCard(
                  title: 'Chat with Doctor',
                  icon: Icons.chat,
                  onTap: () => Navigator.pushNamed(context, '/chat'),
                ),
                ActionCard(
                  title: 'Profile',
                  icon: Icons.person,
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
