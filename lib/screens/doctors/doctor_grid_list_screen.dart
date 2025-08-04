import 'package:flutter/material.dart';

class DoctorGridListScreen extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor1.jpg',
      'status': 'Available',
    },
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor2.jpg',
      'status': 'Available',
    },
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor3.jpg',
      'status': 'Available',
    },
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor_profile.jpg',
      'status': 'Available',
    },
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor_kidene.jpg',
      'status': 'Available',
    },
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor_lungs.jpg',
      'status': 'Available',
    },
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor1.jpg',
      'status': 'Available',
    },
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor2.jpg',
      'status': 'Available',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Top Doctors to Book',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Simply browse through our extensive list of trusted doctors.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 0.72,
              ),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return _DoctorCard(doctor: doctor);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE7EAF3),
                foregroundColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 12,
                ),
              ),
              child: const Text('more', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorCard extends StatefulWidget {
  final Map<String, String> doctor;
  const _DoctorCard({required this.doctor});

  @override
  State<_DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<_DoctorCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovering ? Color(0xFF6D5BBA) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (_hovering)
              BoxShadow(
                color: Color(0xFF6D5BBA).withOpacity(0.18),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: Image.asset(
                widget.doctor['image']!,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.doctor['status']!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.doctor['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Text(
                widget.doctor['specialization']!,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
