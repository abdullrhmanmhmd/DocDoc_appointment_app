import 'package:flutter/material.dart';

import '../core/constants/color_theme.dart';
import '../logic/models/appointment.dart';
import '../logic/models/doctor.dart';
import '../logic/models/sample_data.dart';
import 'appointment_confirmation_screen.dart';

class AppointmentFormScreen extends StatefulWidget {
  final Doctor? initialDoctor;
  final List<Doctor>? availableDoctors;

  const AppointmentFormScreen({
    super.key,
    this.initialDoctor,
    this.availableDoctors,
  });

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();

  late List<Doctor> _doctors;
  Doctor? _selectedDoctor;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _doctors = widget.availableDoctors ?? SampleData.doctors;
    _selectedDoctor = widget.initialDoctor ?? (_doctors.isNotEmpty ? _doctors.first : null);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        _selectedTime = newTime;
      });
    }
  }

  String _formatSelectedDate() {
    if (_selectedDate == null) return 'Select date';
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatFullDate(_selectedDate!);
  }

  String _formatSelectedTime() {
    if (_selectedTime == null) return 'Select time';
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(_selectedTime!, alwaysUse24HourFormat: false);
  }

  void _submit() {
    if (_selectedDoctor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one doctor before booking.')),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose both date and time.')),
      );
      return;
    }

    final appointmentDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final appointment = Appointment(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      doctor: _selectedDoctor!,
      dateTime: appointmentDateTime,
      notes: _notesController.text.trim(),
    );

    AppointmentStore.add(appointment);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AppointmentConfirmationScreen(appointment: appointment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        backgroundColor: MyColors.myBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<Doctor>(
                value: _selectedDoctor,
                decoration: const InputDecoration(
                  labelText: 'Choose Doctor',
                  border: OutlineInputBorder(),
                ),
                items: _doctors
                    .map(
                      (doctor) => DropdownMenuItem(
                        value: doctor,
                        child: Text('${doctor.name} • ${doctor.specialty}'),
                      ),
                    )
                    .toList(),
                onChanged: (doctor) {
                  setState(() {
                    _selectedDoctor = doctor;
                  });
                },
                validator: (value) => value == null ? 'Doctor is required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(_formatSelectedDate()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.access_time),
                      label: Text(_formatSelectedTime()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: MyColors.myBlue,
                  ),
                  child: const Text('Confirm Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

