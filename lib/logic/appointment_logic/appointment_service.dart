import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/appointment.dart';
import 'appointment_validator.dart';
import 'appointment_exceptions.dart';

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
  ///
  /// Throws:
  /// - [AppointmentValidationException] if validation fails
  /// - [AppointmentServiceException] if Firestore operation fails
  Future<Appointment> createAppointment({
    required String userId,
    required String doctorId,
    required String doctorName,
    required DateTime date,
    required String time,
    String? notes,
  }) async {
    try {
      // Validate appointment data
      AppointmentValidator.validateAppointment(
        userId: userId,
        doctorId: doctorId,
        doctorName: doctorName,
        date: date,
        time: time,
      );

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

      debugPrint('Appointment created successfully with ID: ${docRef.id}');

      // Return appointment with generated ID
      return appointment.copyWith(id: docRef.id);
    } on ValidationException catch (e) {
      debugPrint('Validation error: ${e.message}');
      throw AppointmentValidationException(e.message);
    } on FirebaseException catch (e) {
      debugPrint('Firebase error creating appointment: ${e.message}');
      throw AppointmentServiceException(
        'Failed to create appointment: ${e.message}',
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      debugPrint('Unexpected error creating appointment: $e');
      throw AppointmentServiceException(
        'An unexpected error occurred while creating the appointment',
        originalError: e,
      );
    }
  }

  /// Fetches a single appointment by its ID
  ///
  /// Used for appointment confirmation and details screens
  /// Returns null if appointment not found
  ///
  /// Throws:
  /// - [AppointmentServiceException] if Firestore operation fails
  Future<Appointment?> getAppointmentById(String appointmentId) async {
    try {
      if (appointmentId.isEmpty) {
        throw AppointmentValidationException('Appointment ID cannot be empty');
      }

      final docSnapshot = await _firestore
          .collection(_appointmentsCollection)
          .doc(appointmentId)
          .get();

      if (!docSnapshot.exists) {
        debugPrint('Appointment not found: $appointmentId');
        return null;
      }

      return Appointment.fromJson(
        docSnapshot.data() as Map<String, dynamic>,
        docSnapshot.id,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching appointment: ${e.message}');
      throw AppointmentServiceException(
        'Failed to fetch appointment: ${e.message}',
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      debugPrint('Unexpected error fetching appointment: $e');
      throw AppointmentServiceException(
        'An unexpected error occurred while fetching the appointment',
        originalError: e,
      );
    }
  }

  /// Fetches all appointments for a specific user
  ///
  /// Returns list of appointments sorted by date (newest first)
  ///
  /// Throws:
  /// - [AppointmentServiceException] if Firestore operation fails
  Future<List<Appointment>> getUserAppointments(String userId) async {
    try {
      if (userId.isEmpty) {
        throw AppointmentValidationException('User ID cannot be empty');
      }

      final querySnapshot = await _firestore
          .collection(_appointmentsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Appointment.fromJson(doc.data(), doc.id))
          .toList();
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching user appointments: ${e.message}');
      throw AppointmentServiceException(
        'Failed to fetch appointments: ${e.message}',
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      debugPrint('Unexpected error fetching user appointments: $e');
      throw AppointmentServiceException(
        'An unexpected error occurred while fetching appointments',
        originalError: e,
      );
    }
  }

  /// Fetches upcoming appointments for a user
  ///
  /// Filters by status = 'upcoming' and sorts by date (soonest first)
  ///
  /// Throws:
  /// - [AppointmentServiceException] if Firestore operation fails
  Future<List<Appointment>> getUpcomingAppointments(String userId) async {
    try {
      if (userId.isEmpty) {
        throw AppointmentValidationException('User ID cannot be empty');
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
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching upcoming appointments: ${e.message}');
      throw AppointmentServiceException(
        'Failed to fetch upcoming appointments: ${e.message}',
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      debugPrint('Unexpected error fetching upcoming appointments: $e');
      throw AppointmentServiceException(
        'An unexpected error occurred while fetching upcoming appointments',
        originalError: e,
      );
    }
  }

  /// Fetches past appointments for a user
  ///
  /// Filters by status = 'completed' and sorts by date (newest first)
  ///
  /// Throws:
  /// - [AppointmentServiceException] if Firestore operation fails
  Future<List<Appointment>> getPastAppointments(String userId) async {
    try {
      if (userId.isEmpty) {
        throw AppointmentValidationException('User ID cannot be empty');
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
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching past appointments: ${e.message}');
      throw AppointmentServiceException(
        'Failed to fetch past appointments: ${e.message}',
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      debugPrint('Unexpected error fetching past appointments: $e');
      throw AppointmentServiceException(
        'An unexpected error occurred while fetching past appointments',
        originalError: e,
      );
    }
  }

  /// Fetches cancelled appointments for a user
  ///
  /// Filters by status = 'cancelled' and sorts by date (newest first)
  ///
  /// Throws:
  /// - [AppointmentServiceException] if Firestore operation fails
  Future<List<Appointment>> getCancelledAppointments(String userId) async {
    try {
      if (userId.isEmpty) {
        throw AppointmentValidationException('User ID cannot be empty');
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
    } on FirebaseException catch (e) {
      debugPrint(
        'Firebase error fetching cancelled appointments: ${e.message}',
      );
      throw AppointmentServiceException(
        'Failed to fetch cancelled appointments: ${e.message}',
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      debugPrint('Unexpected error fetching cancelled appointments: $e');
      throw AppointmentServiceException(
        'An unexpected error occurred while fetching cancelled appointments',
        originalError: e,
      );
    }
  }

  /// Cancels an appointment by updating its status to 'cancelled'
  ///
  /// Returns true if successful
  ///
  /// Throws:
  /// - [AppointmentNotFoundException] if appointment not found
  /// - [AppointmentServiceException] if Firestore operation fails
  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      if (appointmentId.isEmpty) {
        throw AppointmentValidationException('Appointment ID cannot be empty');
      }

      final docRef = _firestore
          .collection(_appointmentsCollection)
          .doc(appointmentId);

      // Check if document exists
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        throw AppointmentNotFoundException(appointmentId);
      }

      // Update status to cancelled
      await docRef.update({'status': 'cancelled'});

      debugPrint('Appointment cancelled successfully: $appointmentId');
      return true;
    } on AppointmentNotFoundException {
      rethrow;
    } on FirebaseException catch (e) {
      debugPrint('Firebase error cancelling appointment: ${e.message}');
      throw AppointmentServiceException(
        'Failed to cancel appointment: ${e.message}',
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      debugPrint('Unexpected error cancelling appointment: $e');
      throw AppointmentServiceException(
        'An unexpected error occurred while cancelling the appointment',
        originalError: e,
      );
    }
  }
}
