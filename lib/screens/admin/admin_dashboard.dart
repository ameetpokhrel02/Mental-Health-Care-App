import 'package:flutter/material.dart';
import 'add_doctor_screen.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          AdminCard(
            title: 'Manage Doctors',
            icon: Icons.medical_services,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddDoctorScreen()),
            ),
          ),
          AdminCard(
            title: 'View Appointments',
            icon: Icons.calendar_today,
            onTap: () {
              // Navigate to appointments screen
            },
          ),
          AdminCard(
            title: 'User Management',
            icon: Icons.people,
            onTap: () {
              // Navigate to user management
            },
          ),
          AdminCard(
            title: 'Reports',
            icon: Icons.bar_chart,
            onTap: () {
              // Navigate to reports
            },
          ),
        ],
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const AdminCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}