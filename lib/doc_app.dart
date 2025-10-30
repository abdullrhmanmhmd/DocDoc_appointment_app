import 'package:doc_app_sw/color_theme.dart';
import 'package:doc_app_sw/routing/app_router.dart';
import 'package:doc_app_sw/routing/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocApp extends StatelessWidget {
  const DocApp({super.key, required this.appRouter});
  final AppRouter appRouter;
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
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.onboardingScreen,
      ),
    );
  }
}
