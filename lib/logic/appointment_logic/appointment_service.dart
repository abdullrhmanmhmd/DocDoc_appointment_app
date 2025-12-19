import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment.dart';

/// Service class for managing appointment operations with Firebase Firestore
class AppointmentService {
  static final AppointmentService _instance = AppointmentService._internal();
  factory AppointmentService() => _instance;
  AppointmentService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _appointmentsCollection = 'appointments';

  /// Creates a new appointment in Firestore
  ///
  /// Validates inputs and saves to Firestore appointments collection
  /// Returns the created appointment with generated ID
  Future<Appointment> createAppointment({
    required String userId,
    required String doctorId,
    required String doctorName,
    required DateTime date,
    required String time,
    String? notes,
  }) async {
    // Input validation
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }
    if (doctorId.isEmpty) {
      throw ArgumentError('Doctor ID cannot be empty');
    }
    if (doctorName.isEmpty) {
      throw ArgumentError('Doctor name cannot be empty');
    }
    if (time.isEmpty) {
      throw ArgumentError('Time cannot be empty');
    }

    // Create appointment object
    final appointment = Appointment(
      userId: userId,
      doctorId: doctorId,
      doctorName: doctorName,
      date: date,
      time: time,
      notes: notes,
      status: AppointmentStatus.upcoming,
      createdAt: DateTime.now(),
    );

    // Save to Firestore
    final docRef = await _firestore
        .collection(_appointmentsCollection)
        .add(appointment.toJson());

    // Return appointment with generated ID
    return appointment.copyWith(id: docRef.id);
  }
}
