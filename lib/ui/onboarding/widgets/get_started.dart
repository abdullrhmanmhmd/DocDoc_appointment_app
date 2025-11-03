import 'package:doc_app_sw/color_theme.dart';

// Widget that displays the "Get Started" button on the onboarding screen.

import 'package:doc_app_sw/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(MyColors.myBlue),

        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStateProperty.all( Size(double.infinity, 52.h)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),

        ),
      ),
      child: Center(
        child: Text(
          "Get Started",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: MyColors.myWhite,
          ),
        ),
      ),
    );
  }
}
