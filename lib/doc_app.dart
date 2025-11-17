import 'package:doc_app_sw/screens/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/logic/models/doctor.dart';
import 'package:doc_app_sw/widgets/doctor_card_widget.dart';


class DocApp extends StatelessWidget {
  const DocApp({super.key});


  @override
  Widget build(BuildContext context) {
    final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Sarah Ahmed',
      specialty: 'Cardiologist',
      rating: 4.8,
      image: 'assets/images/doctor1.png',
      biography: 'Dr. Sarah is an experienced cardiologist with 10 years in the field...',
      hospital: 'Cairo Heart Institute',
      contact: '+20 123 456 789',
    ),
  ];

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MyColors.myBlue,
          scaffoldBackgroundColor: MyColors.myWhite,
        ),
        home: DoctorCardWidget(doctor: doctors[0]),
      ),
    );
  }
}
