import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/color_theme.dart';
import '../logic/models/doctor.dart';
import '../logic/models/appointment.dart';
import '../widgets/app_text_button.dart';
import '../logic/appointment_logic/appointment_service.dart';
import 'appointment_confirmation_screen.dart';

class AppointmentFormScreen extends StatefulWidget {
  final Doctor? selectedDoctor;

  const AppointmentFormScreen({super.key, this.selectedDoctor});

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  Doctor? _selectedDoctor;
  DateTime? _selectedDate;
  String? _selectedTime;
  final TextEditingController _notesController = TextEditingController();
  final AppointmentService _appointmentService = AppointmentService();
  final List<String> _availableTimes = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDoctor = widget.selectedDoctor;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.myBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTime = null; // Reset time when date changes
      });
    }
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  Future<void> _submitAppointment() async {
    if (_selectedDoctor == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a doctor')));
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a date')));
      return;
    }

    if (_selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a time')));
      return;
    }

    final appointment = Appointment(
      doctor: _selectedDoctor!,
      date: _selectedDate!,
      time: _selectedTime!,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      status: AppointmentStatus.upcoming,
      createdAt: DateTime.now(),
    );

    // Save appointment before navigating
    await _appointmentService.saveAppointment(appointment);

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AppointmentConfirmationScreen(appointment: appointment),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        backgroundColor: MyColors.myWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MyColors.myBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Book Appointment',
          style: TextStyle(
            color: MyColors.myBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Selection Section
            Text(
              'Select Doctor',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () {
                // Navigate to doctor selection screen
                // For now, we'll show a dialog or use the passed doctor
                if (widget.selectedDoctor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Doctor selection feature coming soon'),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: _selectedDoctor != null
                      ? MyColors.myBlue.withOpacity(0.1)
                      : MyColors.myLightGrey,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: _selectedDoctor != null
                        ? MyColors.myBlue
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: _selectedDoctor != null
                    ? Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage: AssetImage(_selectedDoctor!.image),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedDoctor!.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.myBlue,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  _selectedDoctor!.specialty,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: MyColors.myGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: MyColors.myBlue,
                            size: 24.sp,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Icon(
                            Icons.person_add,
                            color: MyColors.myGrey,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Tap to select a doctor',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: MyColors.myGrey,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(height: 30.h),

            // Date Selection Section
            Text(
              'Select Date',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: _selectedDate != null
                      ? MyColors.myBlue.withOpacity(0.1)
                      : MyColors.myLightGrey,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: _selectedDate != null
                        ? MyColors.myBlue
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: _selectedDate != null
                              ? MyColors.myBlue
                              : MyColors.myGrey,
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Select appointment date',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: _selectedDate != null
                                ? MyColors.myBlue
                                : MyColors.myGrey,
                            fontWeight: _selectedDate != null
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    if (_selectedDate != null)
                      Icon(
                        Icons.check_circle,
                        color: MyColors.myBlue,
                        size: 24.sp,
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),

            // Time Selection Section
            if (_selectedDate != null) ...[
              Text(
                'Select Time',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.myBlue,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: _availableTimes.map((time) {
                  final isSelected = _selectedTime == time;
                  return GestureDetector(
                    onTap: () => _selectTime(time),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MyColors.myBlue
                            : MyColors.myLightGrey,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? MyColors.myBlue
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isSelected ? Colors.white : MyColors.myGrey,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 30.h),
            ],

            // Notes Section
            Text(
              'Additional Notes (Optional)',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: MyColors.myLightGrey,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: TextField(
                controller: _notesController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Add any special requests or notes...',
                  hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 14.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.w),
                ),
                style: TextStyle(fontSize: 14.sp, color: MyColors.myBlack),
              ),
            ),
            SizedBox(height: 40.h),

            // Submit Button
            AppTextButton(
              buttonText: 'Confirm Appointment',
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              onPressed: _submitAppointment,
              backgroundColor: MyColors.myBlue,
              borderRadius: 16.r,
              buttonHeight: 56.h,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
