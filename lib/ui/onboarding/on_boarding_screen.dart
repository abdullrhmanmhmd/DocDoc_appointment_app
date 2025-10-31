import 'package:doc_app_sw/ui/onboarding/widgets/doc_logo_and_name.dart';
import 'package:doc_app_sw/ui/onboarding/widgets/doctor_image_and_text.dart';
import 'package:doc_app_sw/ui/onboarding/widgets/get_started.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
            child: Column(
              children: [
                const DocLogoAndName(),
                SizedBox(height: 50.h),
                const DoctorImageAndText(),
                SizedBox(height: 30.h),
                const GetStarted(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
