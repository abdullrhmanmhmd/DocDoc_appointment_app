import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/ui/login/login_screen.dart';
import 'package:doc_app_sw/widgets/app_text_button.dart';
import 'package:doc_app_sw/widgets/app_text_form_field.dart';
import 'package:doc_app_sw/widgets/custom_snack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String email = '';

  resetPassword() async {
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      emailController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnack(
          'Reset password email sent successfully!',
          backgroundColor: Colors.green,
          icon: Icons.check_circle,
        ),
      );
      
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMessage));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                              buttonText: 'Forgot Password',
                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: MyColors.myWhite,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  resetPassword();
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}