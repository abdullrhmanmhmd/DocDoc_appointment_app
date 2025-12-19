import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? id;
  final String userId;
  final String doctorId;
  final String doctorName;
  final DateTime date;
  final String time;
  final String? notes;
  final AppointmentStatus status;
  final DateTime createdAt;

  Appointment({
    this.id,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.date,
    required this.time,
    this.notes,
    this.status = AppointmentStatus.upcoming,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isUpcoming => status == AppointmentStatus.upcoming;
  bool get isPast => status == AppointmentStatus.past;
  bool get isCancelled => status == AppointmentStatus.cancelled;

  Appointment copyWith({
    String? id,
    String? userId,
    String? doctorId,
    String? doctorName,
    DateTime? date,
    String? time,
    String? notes,
    AppointmentStatus? status,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      date: date ?? this.date,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert Appointment to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'date': Timestamp.fromDate(date),
      'time': time,
      'notes': notes,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Create Appointment from Firestore document
  factory Appointment.fromJson(Map<String, dynamic> json, String documentId) {
    return Appointment(
      id: documentId,
      userId: json['userId'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      date: (json['date'] as Timestamp).toDate(),
      time: json['time'] as String,
      notes: json['notes'] as String?,
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.upcoming,
      ),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}

enum AppointmentStatus { upcoming, cancelled, completed }
