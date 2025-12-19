import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/color_theme.dart';
import '../logic/models/appointment.dart';
import '../widgets/app_text_button.dart';
import 'my_appointments_screen.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentConfirmationScreen({super.key, required this.appointment});

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              // Success Icon
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80.sp,
                ),
              ),
              SizedBox(height: 30.h),

              // Success Message
              Text(
                'Appointment Booked!',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.myBlue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                'Your appointment has been successfully booked',
                style: TextStyle(fontSize: 16.sp, color: MyColors.myGrey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),

              // Appointment Summary Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: MyColors.myLightGrey,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: MyColors.myBlue.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appointment Details',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: MyColors.myBlue,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Doctor Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35.r,
                          backgroundColor: MyColors.myBlue.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 35.sp,
                            color: MyColors.myBlue,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment.doctorName,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.myBlack,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Doctor ID: ${appointment.doctorId}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: MyColors.myGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    Divider(color: Colors.grey.shade300),
                    SizedBox(height: 20.h),

                    // Date
                    _buildDetailRow(
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value: _formatDate(appointment.date),
                    ),
                    SizedBox(height: 16.h),

                    // Time
                    _buildDetailRow(
                      icon: Icons.access_time,
                      label: 'Time',
                      value: appointment.time,
                    ),

                    // Notes (if available)
                    if (appointment.notes != null &&
                        appointment.notes!.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      Divider(color: Colors.grey.shade300),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.note, color: MyColors.myBlue, size: 20.sp),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: MyColors.myGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  appointment.notes!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: MyColors.myBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              // Action Buttons
              AppTextButton(
                buttonText: 'View My Appointments',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyAppointmentsScreen(),
                    ),
                    (route) => route.isFirst,
                  );
                },
                backgroundColor: MyColors.myBlue,
                borderRadius: 16.r,
                buttonHeight: 56.h,
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    color: MyColors.myBlue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: MyColors.myBlue, size: 20.sp),
        SizedBox(width: 12.w),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14.sp,
            color: MyColors.myGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.myBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
