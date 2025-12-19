import '../models/appointment.dart';
import '../models/doctor.dart';

class AppointmentRepository {
  Future<Appointment> createAppointment({
    required String userId,
    required Doctor doctor,
    required DateTime date,
    required String time,
    String? notes,
    AppointmentStatus status = AppointmentStatus.upcoming,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    return Appointment(
      id: 'dummy_id',
      userId: userId,
      doctorId: doctor.id,
      doctorName: doctor.name,
      date: date,
      time: time,
      notes: notes,
      status: status,
      createdAt: DateTime.now(),
    );
  }
}
