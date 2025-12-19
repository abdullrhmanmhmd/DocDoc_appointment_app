import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/color_theme.dart';
import '../logic/models/appointment.dart';
import '../logic/appointment_logic/appointment_service.dart';
import 'cancel_appointment_dialog.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AppointmentService _appointmentService = AppointmentService();
  List<Appointment> _upcomingAppointments = [];
  List<Appointment> _pastAppointments = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAppointments();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh appointments when screen is shown
    _loadAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAppointments() async {
    // TODO: Get actual userId from authentication service
    // For now using a placeholder userId
    const String userId = 'current_user_id';

    try {
      final upcoming = await _appointmentService.getUpcomingAppointments(
        userId,
      );
      final past = await _appointmentService.getPastAppointments(userId);

      setState(() {
        _upcomingAppointments = upcoming;
        _pastAppointments = past;
      });
    } catch (e) {
      debugPrint('Error loading appointments: $e');
      // Show error message if needed
    }
  }

  void _updateAppointmentLists() {
    _loadAppointments();
  }

  void _cancelAppointment(Appointment appointment) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => CancelAppointmentDialog(appointment: appointment),
    );

    if (confirmed == true && appointment.id != null) {
      await _appointmentService.cancelAppointment(appointment.id!);
      _updateAppointmentLists();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment cancelled successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.myWhite,
        elevation: 0,
        leading: SizedBox.shrink(),
        title: Text(
          'My Appointments',
          style: TextStyle(
            color: MyColors.myBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: MyColors.myBlue,
          unselectedLabelColor: MyColors.myGrey,
          indicatorColor: MyColors.myBlue,
          indicatorWeight: 3,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Upcoming', style: TextStyle(fontSize: 16.sp)),
                  if (_upcomingAppointments.isNotEmpty) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.myBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${_upcomingAppointments.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Past', style: TextStyle(fontSize: 16.sp)),
                  if (_pastAppointments.isNotEmpty) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.myGrey,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${_pastAppointments.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentsList(_upcomingAppointments, isUpcoming: true),
          _buildAppointmentsList(_pastAppointments, isUpcoming: false),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList(
    List<Appointment> appointments, {
    required bool isUpcoming,
  }) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 80.sp, color: MyColors.myGrey),
            SizedBox(height: 20.h),
            Text(
              isUpcoming ? 'No upcoming appointments' : 'No past appointments',
              style: TextStyle(
                fontSize: 18.sp,
                color: MyColors.myGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isUpcoming
                  ? 'Book your first appointment to get started'
                  : 'Your past appointments will appear here',
              style: TextStyle(fontSize: 14.sp, color: MyColors.myGrey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(appointments[index], isUpcoming);
      },
    );
  }

  Widget _buildAppointmentCard(Appointment appointment, bool isUpcoming) {
    String _formatDate(DateTime date) {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Avatar (placeholder icon since we don't have image reference)
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
                // Doctor Info
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
                          fontSize: 12.sp,
                          color: MyColors.myGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: isUpcoming
                        ? Colors.green.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    isUpcoming ? 'Upcoming' : 'Past',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isUpcoming ? Colors.green : MyColors.myGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Date
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18.sp,
                        color: MyColors.myBlue,
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: MyColors.myGrey,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            _formatDate(appointment.date),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: MyColors.myBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Time
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18.sp,
                        color: MyColors.myBlue,
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: MyColors.myGrey,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            appointment.time,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: MyColors.myBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Cancel Button (only for upcoming appointments)
          if (isUpcoming && !appointment.isCancelled)
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _cancelAppointment(appointment),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'Cancel Appointment',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
