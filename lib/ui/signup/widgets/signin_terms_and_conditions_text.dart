import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninTermsAndConditionsText extends StatelessWidget {
  const SigninTermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 13.sp, height: 1.5, color: MyColors.myGrey),
        children: [
          const TextSpan(text: 'By logging, you agree to our '),
          TextSpan(
            text: 'Terms & Conditions',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: MyColors.myBlack,
            ),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy.',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: MyColors.myBlack,
            ),
          ),
        ],
      ),
    );
  }
}
