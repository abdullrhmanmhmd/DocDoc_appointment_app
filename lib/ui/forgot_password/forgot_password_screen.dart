import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/widgets/app_text_button.dart';
import 'package:doc_app_sw/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.myBlue,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "At our app, we take the security of your\ninformation seriously.",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: MyColors.myGrey,
                ),
              ),
              SizedBox(height: 36.h),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppTextFormField(
                      hintText: 'Email',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 400.h),
                    isLoading
                        ? CircularProgressIndicator(
                            color: MyColors.myBlue,
                            strokeWidth: 2,
                            backgroundColor: MyColors.myWhite,
                          )
                        : AppTextButton(
                            buttonText: 'Reset Password',
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: MyColors.myWhite,
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {}
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
