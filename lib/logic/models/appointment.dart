import 'package:flutter/foundation.dart';

import 'doctor.dart';
import 'sample_data.dart';

class Appointment {
  final String id;
  final Doctor doctor;
  final DateTime dateTime;
  final String notes;

  Appointment({
    required this.id,
    required this.doctor,
    required this.dateTime,
    this.notes = '',
  });

  bool get isUpcoming => dateTime.isAfter(DateTime.now());
}

class AppointmentStore {
  AppointmentStore._();

  static final ValueNotifier<List<Appointment>> appointments =
      ValueNotifier<List<Appointment>>(
    [
      Appointment(
        id: 'seed-1',
        doctor: SampleData.doctors.first,
        dateTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
        notes: 'Routine follow-up visit.',
      ),
      Appointment(
        id: 'seed-2',
        doctor: SampleData.doctors[1],
        dateTime: DateTime.now().subtract(const Duration(days: 5)),
        notes: 'Completed annual skin screening.',
      ),
    ],
  );

  static void add(Appointment appointment) {
    final updated = List<Appointment>.from(appointments.value)..add(appointment);
    updated.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    appointments.value = updated;
  }

  static void cancel(String appointmentId) {
    appointments.value = appointments.value
        .where((appointment) => appointment.id != appointmentId)
        .toList();
  }
}

