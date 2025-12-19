
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllReadyHaveAnAccount extends StatelessWidget {
  const AllReadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Row(
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
            onTap: (){

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text(
              ' Log In',
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
