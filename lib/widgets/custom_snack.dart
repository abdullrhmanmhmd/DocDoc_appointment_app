import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackBar customSnack(
    String message, {
      Color? backgroundColor,
      IconData icon = CupertinoIcons.exclamationmark_circle,
    }) {
  return SnackBar(
    clipBehavior: Clip.none,
    backgroundColor: backgroundColor ?? Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 50.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: MyColors.myWhite,
          size: 20.sp,
        ),
        SizedBox(width: 10.w),
        Text(
          message,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: MyColors.myWhite,
            height: 1.3,
          ),
          maxLines: null,
          softWrap: true,
        ),
      ],
    ),
    duration: const Duration(seconds: 5),
  );
}
