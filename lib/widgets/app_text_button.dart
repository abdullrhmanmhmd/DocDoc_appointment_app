import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonWidth,
    this.buttonHeight,
    this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
  });

  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String buttonText;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor ?? MyColors.myBlue,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? 12.w,
            vertical: verticalPadding?.h ?? 14.h,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.sp),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(buttonWidth?.w ?? double.maxFinite, buttonHeight ?? 50.h),
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonText, style: textStyle),
    );
  }
}
