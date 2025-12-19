/// Custom exceptions for appointment service operations

/// Base exception for appointment-related errors
class AppointmentException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppointmentException(this.message, {this.code, this.originalError});

  @override
  String toString() =>
      'AppointmentException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Thrown when an appointment is not found
class AppointmentNotFoundException extends AppointmentException {
  AppointmentNotFoundException(String appointmentId)
    : super('Appointment not found with ID: $appointmentId', code: 'NOT_FOUND');
}

/// Thrown when appointment validation fails
class AppointmentValidationException extends AppointmentException {
  AppointmentValidationException(String message)
    : super(message, code: 'VALIDATION_ERROR');
}

/// Thrown when a Firestore operation fails
class AppointmentServiceException extends AppointmentException {
  AppointmentServiceException(
    String message, {
    String? code,
    dynamic originalError,
  }) : super(message, code: code, originalError: originalError);
}

/// Thrown when user is not authorized to perform an operation
class AppointmentUnauthorizedException extends AppointmentException {
  AppointmentUnauthorizedException(String message)
    : super(message, code: 'UNAUTHORIZED');
}
