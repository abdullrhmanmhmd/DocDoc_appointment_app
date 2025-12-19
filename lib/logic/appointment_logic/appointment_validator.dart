/// Validation utility for appointment data
///
/// Provides methods to validate appointment fields before saving to Firestore
class AppointmentValidator {
  /// Validates that required fields are not empty
  static void validateRequiredFields({
    required String userId,
    required String doctorId,
    required String doctorName,
    required String time,
  }) {
    if (userId.trim().isEmpty) {
      throw ValidationException('User ID cannot be empty');
    }
    if (doctorId.trim().isEmpty) {
      throw ValidationException('Doctor ID cannot be empty');
    }
    if (doctorName.trim().isEmpty) {
      throw ValidationException('Doctor name cannot be empty');
    }
    if (time.trim().isEmpty) {
      throw ValidationException('Appointment time cannot be empty');
    }
  }

  /// Validates that the appointment date is not in the past
  static void validateAppointmentDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDay = DateTime(date.year, date.month, date.day);

    if (appointmentDay.isBefore(today)) {
      throw ValidationException(
        'Cannot book appointment in the past. Please select a future date.',
      );
    }
  }

  /// Validates time format (basic check for HH:MM format)
  static void validateTimeFormat(String time) {
    // Basic regex for time format like "10:30 AM" or "14:30"
    final timePattern = RegExp(
      r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9](\s?(AM|PM|am|pm))?$',
    );

    if (!timePattern.hasMatch(time.trim())) {
      throw ValidationException(
        'Invalid time format. Expected format: HH:MM or HH:MM AM/PM',
      );
    }
  }

  /// Validates all appointment data
  static void validateAppointment({
    required String userId,
    required String doctorId,
    required String doctorName,
    required DateTime date,
    required String time,
  }) {
    validateRequiredFields(
      userId: userId,
      doctorId: doctorId,
      doctorName: doctorName,
      time: time,
    );
    validateAppointmentDate(date);
    validateTimeFormat(time);
  }
}

/// Custom exception for validation errors
class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}
