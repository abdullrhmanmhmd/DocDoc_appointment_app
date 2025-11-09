import 'package:flutter/material.dart';
import '../models/doctor.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // this is the doctor image
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(doctor.image),
              ),
            ),
            const SizedBox(height: 20),

            // here is the name and specialty
            Center(
              child: Column(
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    doctor.specialty,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 5),
                      Text(
                        doctor.rating.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // this is the biography
            const Text(
              'Biography',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              doctor.biography,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),

            const SizedBox(height: 25),

            // here is the hospital information
            const Text(
              'Hospital',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              doctor.hospital,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // this is the contact information
            const Text(
              'Contact',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              doctor.contact,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            // here is the Book Appointment Button //
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booking with ${doctor.name} coming soon!'),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Book Appointment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

