import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// Widget that displays the DocDoc logo alongside the app name.

class DocLogoAndName extends StatelessWidget {
  const DocLogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svgs/docdoc_logo.svg', ),
        SizedBox(width: 10.w),
        SvgPicture.asset('assets/svgs/Docdoc.svg', ),
      ],
    );
  }
}
