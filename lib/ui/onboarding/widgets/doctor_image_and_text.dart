
import 'package:doc_app_sw/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget that displays an image and text for the doctor onboarding screen.

class DoctorImageAndText extends StatelessWidget {
  const DoctorImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: 475.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/svgs/doc_doc_logo_low_obesity.svg',
            fit: BoxFit.contain,
            width: double.infinity,
          ),
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0.0)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.14, 0.4],
              ),
            ),
            child: Image.asset('assets/images/onboarding_doctor.png'),
          ),
          Positioned(
            bottom: 20.h,

            child: Text(
              textAlign: TextAlign.center,
              "Best Doctor\nAppointment App",
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
