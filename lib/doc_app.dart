import 'package:doc_app_sw/screens/doctor_details_screen.dart';
import 'package:doc_app_sw/ui/onboarding/on_boarding_screen.dart';
import 'package:doc_app_sw/ui/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/logic/models/doctor.dart';
import 'package:doc_app_sw/widgets/doctor_card_widget.dart';
import 'package:doc_app_sw/screens/search_screen.dart';
import 'package:doc_app_sw/screens/home_screen.dart';
import 'package:doc_app_sw/ui/login/login_screen.dart';




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
        biography:
            'Dr. Sarah is an experienced cardiologist with 10 years in the field...',
        hospital: 'Cairo Heart Institute',
        contact: '+20 123 456 789',
      ),

    Doctor(
    name: 'Dr. Mohammed Ali',
    specialty: 'Neurologist',
    rating: 4.6,
    image: 'assets/images/doctor2.png',
    biography:
    'Expert neurologist with 8 years of helping patients with brain disorders.',
    hospital: 'Alex Neuro Center',
    contact: '+20 987 654 321',
    ),

    Doctor(
    name: 'Dr. Mariam Hassan',
    specialty: 'Pediatrician',
    rating: 4.9,
    image: 'assets/images/doctor3.png',
    biography:
    'Highly skilled pediatric doctor specializing in child wellness.',
    hospital: 'Cairo Children Hospital',
    contact: '+20 111 222 333',
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
        home:SignUpScreen(),
      ),
    );
  }
}
