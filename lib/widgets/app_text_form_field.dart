
import 'package:doc_app_sw/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.isPassword,
    required this.hintText,
    this.suffixIcon,
    this.hintStyle,
    this.backgroundColor,
    this.controller,
    this.validator,
  });

  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final bool? isPassword;
  final String? hintText;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: MyColors.myBlue,
          selectionColor: MyColors.myBlue,
          selectionHandleColor: MyColors.myBlue,
        ),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPassword ?? false,
        cursorColor: MyColors.myBlue,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor ?? const Color.fromRGBO(253, 253, 255, 1),
          isDense: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color.fromRGBO(237, 237, 237, 1),
                  width: 1.4.w,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.myBlue, width: 1.4.w),
                borderRadius: BorderRadius.circular(16.sp),
              ),
          hintStyle: hintStyle ??
              TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(194, 194, 194, 1),
              ),
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: MyColors.myDarkBlue,
        ),
      ),
    );
  }
}
