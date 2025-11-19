import 'package:flutter/material.dart';

import '../core/constants/color_theme.dart';
import '../logic/models/appointment.dart';
import 'appointment_form_screen.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  void _openCancelDialog(BuildContext context, Appointment appointment) async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel appointment?'),
        content: const Text(
          'This action cannot be undone. Do you want to cancel this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Cancel Appointment'),
          ),
        ],
      ),
    );

    if (shouldCancel ?? false) {
      AppointmentStore.cancel(appointment.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment cancelled.')),
      );
    }
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<Appointment> appointments,
    bool isUpcoming = false,
  }) {
    if (appointments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...appointments.map(
          (appointment) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: MyColors.myBlue.withOpacity(0.1),
                child: const Icon(Icons.medical_information, color: Colors.black87),
              ),
              title: Text(appointment.doctor.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appointment.doctor.specialty),
                  const SizedBox(height: 4),
                  Text(_formatDate(context, appointment.dateTime)),
                  if (appointment.notes.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      appointment.notes,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ],
              ),
              trailing: isUpcoming
                  ? TextButton(
                      onPressed: () => _openCancelDialog(context, appointment),
                      child: const Text('Cancel'),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(BuildContext context, DateTime dateTime) {
    final localization = MaterialLocalizations.of(context);
    final date = localization.formatCompactDate(dateTime);
    final time = localization.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime));
    return '$date • $time';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        title: const Text('My Appointments'),
        backgroundColor: MyColors.myBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Book new',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppointmentFormScreen()),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Appointment>>(
        valueListenable: AppointmentStore.appointments,
        builder: (context, appointments, _) {
          if (appointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.event_busy, size: 48, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Text('No appointments yet'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AppointmentFormScreen()),
                      );
                    },
                    child: const Text('Book one now'),
                  ),
                ],
              ),
            );
          }

          final upcoming = appointments.where((appointment) => appointment.isUpcoming).toList();
          final past = appointments.where((appointment) => !appointment.isUpcoming).toList();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    context: context,
                    title: 'Upcoming',
                    appointments: upcoming,
                    isUpcoming: true,
                  ),
                  _buildSection(
                    context: context,
                    title: 'Past',
                    appointments: past,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

