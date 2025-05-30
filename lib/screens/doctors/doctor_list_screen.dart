 import 'package:flutter/material.dart';
 import 'package:new_flutter_project/services/api_service.dart';
 import '../../models/doctor.dart';
 import '../../services/api_service.dart';
// import '../../services/api_service.dart' as ApiService show getDoctors;

// class DoctorListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Our Doctors'),
//       ),
//       body: FutureBuilder<List<Doctor>>(
//         future: ApiService.getDoctors(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
          
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final doctors = snapshot.data ?? [];
          
//           return ListView.builder(
//             itemCount: doctors.length,
//             itemBuilder: (context, index) {
//               final doctor = doctors[index];
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 child: ListTile(
//                   leading: doctor.imageUrl != null
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(25),
//                           child: Image.network(
//                             'http://localhost:3000${doctor.imageUrl}',
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Icon(Icons.person, size: 50);
//                             },
//                           ),
//                         )
//                       : Icon(Icons.person, size: 50),
//                   title: Text(doctor.name),
//                   subtitle: Text('${doctor.specialization}\n${doctor.experience} years experience'),
//                   isThreeLine: true,
//                   onTap: () {
//                     // Handle doctor selection
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }