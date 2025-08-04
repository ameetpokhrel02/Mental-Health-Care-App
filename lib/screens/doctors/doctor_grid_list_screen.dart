import 'package:flutter/material.dart';

class DoctorGridListScreen extends StatefulWidget {
  const DoctorGridListScreen({Key? key}) : super(key: key);
  @override
  State<DoctorGridListScreen> createState() => _DoctorGridListScreenState();
}

class _DoctorGridListScreenState extends State<DoctorGridListScreen> {
  final List<Map<String, dynamic>> allDoctors = [
    {
      'name': 'Dr. William Carlton',
      'specialization': 'Orthopedic',
      'image': 'assets/images/doctor1.jpg',
      'reviews': 48,
      'rating': 4.9,
      'color': Color(0xFFE3E8FF),
    },
    {
      'name': 'Dr. Maskot Arnar',
      'specialization': 'Neurologist',
      'image': 'assets/images/doctor2.jpg',
      'reviews': 40,
      'rating': 4.8,
      'color': Color(0xFFFFF3E3),
    },
    {
      'name': 'Dr. Richard James',
      'specialization': 'General physician',
      'image': 'assets/images/doctor3.jpg',
      'reviews': 32,
      'rating': 4.7,
      'color': Color(0xFFFFE3E3),
    },
    {
      'name': 'Dr. Anna Smith',
      'specialization': 'Cardiologist',
      'image': 'assets/images/doctor_profile.jpg',
      'reviews': 28,
      'rating': 4.8,
      'color': Color(0xFFE3FFF6),
    },
    {
      'name': 'Dr. John Doe',
      'specialization': 'Kidney Specialist',
      'image': 'assets/images/doctor_kidene.jpg',
      'reviews': 22,
      'rating': 4.6,
      'color': Color(0xFFE3F0FF),
    },
    {
      'name': 'Dr. Lisa Ray',
      'specialization': 'Pulmonologist',
      'image': 'assets/images/doctor_lungs.jpg',
      'reviews': 19,
      'rating': 4.5,
      'color': Color(0xFFFFE3F6),
    },
    // Nepali doctors
    {
      'name': 'Dr. Ramchandra',
      'specialization': 'Cardiologist',
      'image': 'assets/images/doctor1.jpg',
      'reviews': 25,
      'rating': 4.7,
      'color': Color(0xFFE3E8FF),
    },
    {
      'name': 'Dr. Isha Oathak',
      'specialization': 'Kidney Specialist',
      'image': 'assets/images/doctor2.jpg',
      'reviews': 18,
      'rating': 4.6,
      'color': Color(0xFFFFF3E3),
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {'label': 'All', 'icon': Icons.grid_view},
    {'label': 'Kidney', 'icon': Icons.medical_services},
    {'label': 'Heart', 'icon': Icons.favorite_border},
    {'label': 'Virus', 'icon': Icons.coronavirus},
    {'label': 'Lungs', 'icon': Icons.air},
  ];

  // Map category label to specialization for filtering
  final Map<String, String> categoryToSpecialization = {
    'Kidney': 'Kidney Specialist',
    'Heart': 'Cardiologist',
    'Virus': 'General physician',
    'Lungs': 'Pulmonologist',
  };

  int selectedCategory = 0;
  String searchQuery = '';

  List<Map<String, dynamic>> get filteredDoctors {
    final selected = categories[selectedCategory]['label'].toString();
    return allDoctors.where((doc) {
      bool matchesCategory = true;
      if (selected != 'All') {
        final specialization = categoryToSpecialization[selected];
        matchesCategory =
            specialization != null &&
            doc['specialization'].toString().toLowerCase().contains(
              specialization.toLowerCase(),
            );
      }
      final matchesSearch =
          searchQuery.isEmpty ||
          doc['name'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          doc['specialization'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Top Doctors to Book',
          style: TextStyle(
            // (Removed duplicate build method)
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar and filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (val) => setState(() => searchQuery = val),
                        decoration: InputDecoration(
                          hintText: 'Find your doctor',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2563FF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.tune, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Categories
              const Text(
                'Categories by',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final cat = categories[i];
                    final selected = i == selectedCategory;
                    return FilterChip(
                      label: Text(
                        cat['label'],
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      avatar: Icon(
                        cat['icon'],
                        size: 18,
                        color: selected ? Colors.white : Colors.black54,
                      ),
                      selected: selected,
                      selectedColor: Color(0xFF2563FF),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                      ),
                      onSelected: (_) => setState(() => selectedCategory = i),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              // Popular by
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular by',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(
                        color: Color(0xFF2563FF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredDoctors.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return DoctorCardModern(
                    doctor: doctor,
                    onDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DoctorDetailsScreen(doctor: doctor),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCardModern extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final VoidCallback? onDetails;
  const DoctorCardModern({required this.doctor, this.onDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: doctor['color'] ?? Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                doctor['image'],
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              doctor['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              doctor['specialization'],
              style: const TextStyle(color: Colors.black54, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                const SizedBox(width: 2),
                Text(
                  '${doctor['rating']}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
                const SizedBox(width: 8),
                Icon(Icons.reviews, color: Colors.grey, size: 15),
                const SizedBox(width: 2),
                Text(
                  '${doctor['reviews']} Review',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2563FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              child: const Text('Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;
  const DoctorDetailsScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor['name']),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Doctor details coming soon!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// (Removed duplicate DoctorCardModern build method)
