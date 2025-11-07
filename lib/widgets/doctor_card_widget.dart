
import 'package:flutter/material.dart';
import '../models/doctor.dart';


class DoctorCardWidget extends StatelessWidget {
  final Doctor doctor;
  const DoctorCardWidget({super.key, required this.doctor});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(doctor.image),
          radius: 28,
        ),
        title: Text(
          doctor.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${doctor.specialty}\n ${doctor.rating.toString()}'),
        isThreeLine: true,
      ),
    );
  }
}
