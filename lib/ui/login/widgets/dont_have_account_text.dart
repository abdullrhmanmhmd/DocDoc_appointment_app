import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/ui/signup/sign_up_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// make sure you import your SignUpScreen file

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: MyColors.myBlack,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>  SignUpScreen(),
              ),
            );
          },
          child: Text(
            ' Sign In',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: MyColors.myBlue,
            ),
          ),
        ),
      ],
    );
  }
}
