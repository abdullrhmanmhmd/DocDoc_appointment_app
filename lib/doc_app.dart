import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/logic/models/sample_data.dart';
import 'package:doc_app_sw/screens/search_screen.dart';

class DocApp extends StatelessWidget {
  const DocApp({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = SampleData.doctors;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MyColors.myBlue,
          scaffoldBackgroundColor: MyColors.myWhite,
        ),
        home: SearchScreen(doctors: doctors),
      ),
    );
  }
}
