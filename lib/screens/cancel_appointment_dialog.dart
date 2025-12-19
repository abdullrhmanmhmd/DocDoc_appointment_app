import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/color_theme.dart';
import '../logic/models/appointment.dart';

class CancelAppointmentDialog extends StatelessWidget {
  final Appointment appointment;

  const CancelAppointmentDialog({super.key, required this.appointment});

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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning Icon
            Center(
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red.shade700,
                  size: 50.sp,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              'Cancel Appointment?',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlack,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            // Message
            Text(
              'Are you sure you want to cancel this appointment? This action cannot be undone.',
              style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.myGrey,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),

            // Appointment Details
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: MyColors.myLightGrey,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: MyColors.myBlue.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 25.sp,
                          color: MyColors.myBlue,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.doctorName,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: MyColors.myBlack,
                              ),
                            ),
                            Text(
                              'ID: ${appointment.doctorId}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: MyColors.myGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: Colors.grey.shade300),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.sp,
                        color: MyColors.myGrey,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _formatDate(appointment.date),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.myBlack,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.access_time,
                        size: 16.sp,
                        color: MyColors.myGrey,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        appointment.time,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.myBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: MyColors.myGrey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Keep Appointment',
                      style: TextStyle(
                        color: MyColors.myGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Cancel Appointment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
