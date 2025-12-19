import 'package:flutter/material.dart';
import '../logic/models/doctor.dart';
import '../core/constants/color_theme.dart';
import 'appointment_form_screen.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        title: Text(doctor.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: MyColors.myBlue,
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[200],
                backgroundImage: doctor.image.startsWith('http')
                    ? NetworkImage(doctor.image)
                    : AssetImage(doctor.image) as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    doctor.specialty,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Biography',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),


            const SizedBox(height: 10),
            Text(
              doctor.biography,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),

            const SizedBox(height: 25),

            Text(
              'Hospital',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),


            const SizedBox(height: 10),
            Text(doctor.hospital, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 25),

            Text(
              'Contact',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),
            const SizedBox(height: 10),
            Text(doctor.contact, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 30),


            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AppointmentFormScreen(selectedDoctor: doctor),
                    ),
                  );
                },


                icon: const Icon(Icons.calendar_today),
                label: const Text('Book Appointment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.myBlue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
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
