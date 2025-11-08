import 'package:doc_app_sw/color_theme.dart';

import 'package:doc_app_sw/ui/login/login_screen.dart';


import 'package:doc_app_sw/ui/onboarding/on_boarding_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocApp extends StatelessWidget {
  const DocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MyColors.myBlue,
          scaffoldBackgroundColor: MyColors.myWhite,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
