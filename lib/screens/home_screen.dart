import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card_widget.dart';

class HomeScreen extends StatelessWidget {
  final List<Doctor> doctors;
  const HomeScreen({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Doctors')),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return DoctorCardWidget(doctor: doctor);
        },
      ),
    );
  }
}


