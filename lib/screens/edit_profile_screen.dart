import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/widgets/app_text_button.dart';
import 'package:doc_app_sw/widgets/app_text_form_field.dart';
import 'package:doc_app_sw/widgets/custom_snack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw Exception('No authenticated user');
      }

      // Update display name
      if (nameController.text.trim().isNotEmpty) {
        await user.updateDisplayName(nameController.text.trim());
      }

      // Update password
      if (passwordController.text.isNotEmpty) {
        await user.updatePassword(passwordController.text.trim());
      }

      await user.reload();

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        customSnack(
          'Profile updated successfully',
          backgroundColor: Colors.green,
          icon: Icons.check_circle,
        ),
      );

      Navigator.pop(context, true);
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        customSnack(e.message ?? 'Authentication error'),
      );
    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        customSnack('Something went wrong'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 60,
      onRefresh: () async {
        FocusScope.of(context).unfocus();
      },
      color: MyColors.myBlue,
      backgroundColor: Colors.transparent,
      child: Scaffold(
        backgroundColor: MyColors.myWhite,

        appBar: AppBar(
          backgroundColor: MyColors.myWhite,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Edit Profile",
              style: TextStyle(
                color: MyColors.myBlack,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        
        ),

        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Skeletonizer(
            enabled: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.myBlue,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 80.sp,
                        color: MyColors.myWhite,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 30.h),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppTextFormField(
                          hintText: 'Name',
                          controller: nameController,
                          validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                        ),
                        SizedBox(height: 18.h),

                        AppTextFormField(
                          hintText: 'New Password',
                          controller: passwordController,
                          isPassword: isObscure,
                          validator: (value) =>
                          value!.isEmpty ? 'Please enter your new password' : null,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                setState(() => isObscure = !isObscure),
                            child: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: MyColors.myGrey,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),

                        AppTextFormField(
                          hintText: 'Confirm New Password',
                          controller: confirmPasswordController,
                          isPassword: isObscure,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your new password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                setState(() => isObscure = !isObscure),
                            child: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: MyColors.myGrey,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),

                        isLoading
                            ? CircularProgressIndicator(
                          color: MyColors.myBlue,
                          strokeWidth: 2,
                        )
                            : AppTextButton(
                          buttonText: 'Save',
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: MyColors.myWhite,
                          ),
                          onPressed: updateProfile,
                        ),
                      ],
                    ),
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