import 'doctor.dart';

class Appointment {
  final String? id;
  final Doctor doctor;
  final DateTime date;
  final String time;
  final String? notes;
  final AppointmentStatus status;
  final DateTime? createdAt;

  Appointment({
    this.id,
    required this.doctor,
    required this.date,
    required this.time,
    this.notes,
    this.status = AppointmentStatus.upcoming,
    this.createdAt,
  });

  bool get isUpcoming => status == AppointmentStatus.upcoming;
  bool get isPast => status == AppointmentStatus.past;
  bool get isCancelled => status == AppointmentStatus.cancelled;

  Appointment copyWith({
    String? id,
    Doctor? doctor,
    DateTime? date,
    String? time,
    String? notes,
    AppointmentStatus? status,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      date: date ?? this.date,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

enum AppointmentStatus { upcoming, past, cancelled }
