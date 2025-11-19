import 'package:flutter/material.dart';

import '../core/constants/color_theme.dart';
import '../logic/models/appointment.dart';
import 'my_appointments_screen.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentConfirmationScreen({super.key, required this.appointment});

  String _formattedDate(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return '${localizations.formatFullDate(appointment.dateTime)} at ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(appointment.dateTime))}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        title: const Text('Appointment Confirmed'),
        backgroundColor: MyColors.myBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              backgroundColor: MyColors.myBlue.withOpacity(0.1),
              radius: 60,
              child: Icon(
                Icons.check_circle,
                size: 80,
                color: MyColors.myBlue,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Booking Successful!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'You\'re all set for your visit.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctor.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      appointment.doctor.specialty,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(_formattedDate(context))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (appointment.notes.isNotEmpty)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.note, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(appointment.notes)),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyAppointmentsScreen(),
                    ),
                    (route) => route.isFirst,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.myBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('View My Appointments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

