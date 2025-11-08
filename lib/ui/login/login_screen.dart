import 'package:doc_app_sw/color_theme.dart';
import 'package:doc_app_sw/ui/login/widgets/dont_have_account_text.dart';
import 'package:doc_app_sw/ui/login/widgets/login_terms_and_conditions_text.dart';
import 'package:doc_app_sw/widgets/app_text_button.dart';
import 'package:doc_app_sw/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: MyColors.myBlue,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "We're excited to have you back, can't wait to see what you've been up to since you last\nlogged in.",
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
                      SizedBox(height: 18.h),
                      AppTextFormField(
                        hintText: 'Password',
                        controller: passwordController,
                        isPassword: isObscure,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() => isObscure = !isObscure);
                          },
                          child: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: MyColors.myGrey,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 22.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: MyColors.myBlue,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      AppTextButton(
                        buttonText: 'Login',
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.myWhite,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(height: 24.h),
                      const LoginTermsAndConditionsText(),
                      SizedBox(height: 60.h),
                      const DontHaveAccountText(),
                    ],
                  ),
                ),
              ],
            ),
          ), )
    );
  }
}