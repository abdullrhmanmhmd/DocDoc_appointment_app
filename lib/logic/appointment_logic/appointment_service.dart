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

  /// Fetches a single appointment by its ID
  ///
  /// Used for appointment confirmation and details screens
  /// Returns null if appointment not found
  Future<Appointment?> getAppointmentById(String appointmentId) async {
    if (appointmentId.isEmpty) {
      throw ArgumentError('Appointment ID cannot be empty');
    }

    final docSnapshot = await _firestore
        .collection(_appointmentsCollection)
        .doc(appointmentId)
        .get();

    if (!docSnapshot.exists) {
      return null;
    }

    return Appointment.fromJson(
      docSnapshot.data() as Map<String, dynamic>,
      docSnapshot.id,
    );
  }

  /// Fetches all appointments for a specific user
  ///
  /// Returns list of appointments sorted by date (newest first)
  Future<List<Appointment>> getUserAppointments(String userId) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    final querySnapshot = await _firestore
        .collection(_appointmentsCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Appointment.fromJson(doc.data(), doc.id))
        .toList();
  }

  /// Fetches upcoming appointments for a user
  ///
  /// Filters by status = 'upcoming' and sorts by date (soonest first)
  Future<List<Appointment>> getUpcomingAppointments(String userId) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    final querySnapshot = await _firestore
        .collection(_appointmentsCollection)
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'upcoming')
        .orderBy('date', descending: false)
        .get();

    return querySnapshot.docs
        .map((doc) => Appointment.fromJson(doc.data(), doc.id))
        .toList();
  }

  /// Fetches past appointments for a user
  ///
  /// Filters by status = 'completed' and sorts by date (newest first)
  Future<List<Appointment>> getPastAppointments(String userId) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    final querySnapshot = await _firestore
        .collection(_appointmentsCollection)
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'completed')
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Appointment.fromJson(doc.data(), doc.id))
        .toList();
  }

  /// Fetches cancelled appointments for a user
  ///
  /// Filters by status = 'cancelled' and sorts by date (newest first)
  Future<List<Appointment>> getCancelledAppointments(String userId) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    final querySnapshot = await _firestore
        .collection(_appointmentsCollection)
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'cancelled')
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Appointment.fromJson(doc.data(), doc.id))
        .toList();
  }

  /// Cancels an appointment by updating its status to 'cancelled'
  ///
  /// Returns true if successful, false if appointment not found
  Future<bool> cancelAppointment(String appointmentId) async {
    if (appointmentId.isEmpty) {
      throw ArgumentError('Appointment ID cannot be empty');
    }

    final docRef = _firestore
        .collection(_appointmentsCollection)
        .doc(appointmentId);

    // Check if document exists
    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return false;
    }

    // Update status to cancelled
    await docRef.update({'status': 'cancelled'});

    return true;
  }
}
