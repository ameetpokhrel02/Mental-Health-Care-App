import 'package:flutter/material.dart';

class DoctorListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Kidney Specialist',
      'image': 'assets/images/doctor_kidney.jpg',
      'icon': Icons.medical_services,
      'experience': '15 years',
      'rating': 4.8,
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Pulmonologist',
      'image': 'assets/images/doctor_lungs.jpg',
      'icon': Icons.medical_services,
      'experience': '12 years',
      'rating': 4.7,
    },
    // Add more doctors...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Doctors'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return DoctorCard(doctor: doctor);
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(doctor['image']),
          radius: 30,
        ),
        title: Text(doctor['name']),
        subtitle: Row(
          children: [
            Icon(doctor['icon'], size: 16),
            SizedBox(width: 4),
            Text(doctor['specialty']),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('⭐ ${doctor['rating']}'),
            Text('${doctor['experience']}'),
          ],
        ),
        onTap: () {
          // Navigate to doctor detail
        },
      ),
    );
  }
}