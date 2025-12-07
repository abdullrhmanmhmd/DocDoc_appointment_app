import '../models/appointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentService {
  static const String _appointmentsKey = 'appointments';
  static final AppointmentService _instance = AppointmentService._internal();
  factory AppointmentService() => _instance;
  AppointmentService._internal();

  List<Appointment> _appointments = [];

  List<Appointment> get appointments => List.unmodifiable(_appointments);

  Future<void> loadAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final appointmentsJson = prefs.getString(_appointmentsKey);
      if (appointmentsJson != null) {
        // Note: This is a simplified version. In a real app, you'd need to
        // properly deserialize the Doctor object as well.
        // For now, we'll keep appointments in memory and save them.
        // final List<dynamic> decoded = json.decode(appointmentsJson);
        _appointments = [];
      }
    } catch (e) {
      _appointments = [];
    }
  }

  Future<void> saveAppointment(Appointment appointment) async {
    // Generate a simple ID if not present
    final appointmentWithId = appointment.id == null
        ? appointment.copyWith(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
          )
        : appointment;

    _appointments.add(appointmentWithId);
    await _saveToStorage();
  }

  Future<void> cancelAppointment(String appointmentId) async {
    _appointments = _appointments.map((apt) {
      if (apt.id == appointmentId) {
        return apt.copyWith(status: AppointmentStatus.cancelled);
      }
      return apt;
    }).toList();
    await _saveToStorage();
  }

  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // For simplicity, we'll store a count. In a real app, you'd serialize
      // the full appointment objects with their doctor references.
      // This is a placeholder - you'd need proper JSON serialization
      await prefs.setInt('appointments_count', _appointments.length);
    } catch (e) {
      // Handle error silently for now
    }
  }

  List<Appointment> getUpcomingAppointments() {
    final now = DateTime.now();
    return _appointments
        .where(
          (apt) =>
              apt.status == AppointmentStatus.upcoming &&
              (apt.date.isAfter(now) ||
                  (apt.date.year == now.year &&
                      apt.date.month == now.month &&
                      apt.date.day == now.day &&
                      _isTimeAfterNow(apt.time))),
        )
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  List<Appointment> getPastAppointments() {
    final now = DateTime.now();
    return _appointments
        .where(
          (apt) =>
              apt.status == AppointmentStatus.past ||
              (apt.status == AppointmentStatus.upcoming &&
                  (apt.date.isBefore(now) ||
                      (apt.date.year == now.year &&
                          apt.date.month == now.month &&
                          apt.date.day == now.day &&
                          !_isTimeAfterNow(apt.time)))),
        )
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  bool _isTimeAfterNow(String time) {
    // Simple check - in a real app, you'd parse the time properly
    // For now, we'll assume if the date is today, it's upcoming
    return true;
  }
}
