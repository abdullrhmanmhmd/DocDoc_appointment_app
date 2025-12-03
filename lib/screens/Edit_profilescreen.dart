// import 'package:docdoc/core/constants/my_colors.dart';
// import 'package:docdoc/core/network/api_error.dart';
// import 'package:docdoc/logic/auth/auth_repo.dart';
// import 'package:docdoc/logic/models/user_model.dart';
// // import 'package:docdoc/logic/auth/user_model.dart';
// import 'package:docdoc/ui/profile/profile_screen.dart';
// import 'package:docdoc/ui/widgets/app_text_button.dart';
// import 'package:docdoc/ui/widgets/app_text_form_field.dart';
// import 'package:docdoc/ui/widgets/bottom_navigation.dart';
// import 'package:docdoc/ui/widgets/custom_snack.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class UpdateProfileScreen extends StatefulWidget {
//   const UpdateProfileScreen({super.key});

//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }

// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//   final formKey = GlobalKey<FormState>();
//   bool isObscure = true;
//   bool isLoading = false;
//   UserModel? userModel;

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//   TextEditingController();

//   final AuthRepo authRepo = AuthRepo();


//   Future<void> updateProfile() async {
//     if (!formKey.currentState!.validate()) return;

//     setState(() => isLoading = true);

//     try {
//       final user = await authRepo.updateUser(
//         nameController.text.trim(),
//         emailController.text.trim(),
//         phoneController.text.trim(),
//         passwordController.text.trim(),
//         confirmPasswordController.text.trim(),
//       );

//       setState(() {
//         userModel = user;
//         isLoading = false;
//       });

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(customSnack(
//         'Profile updated successfully',
//         backgroundColor: Colors.green,
//         icon: Icons.check_circle,
//       ));


//       Navigator.pop(context,true);
//     } catch (e) {
//       setState(() => isLoading = false);

//       String? error;
//       if (e is ApiError) error = e.massage;

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(customSnack(error ?? 'Failed to update profile'));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       displacement: 60,
//       onRefresh: () async {
//         FocusScope.of(context).unfocus();
//         // Here you can call a real getProfile() if you have one
//       },
//       color: MyColors.myBlue,
//       backgroundColor:Colors.transparent,
//       child: Scaffold(
//         backgroundColor: MyColors.myWhite,
//         appBar: AppBar(
//           backgroundColor: MyColors.myWhite,
//           elevation: 0,
//           centerTitle: true,
//           title: Padding(
//             padding: const EdgeInsets.only(top: 25),
//             child: Text(
//               "Edit Profile",
//               style: TextStyle(
//                 color: MyColors.myBlack,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           leading: Padding(
//             padding: const EdgeInsets.only(top: 25),
//             child: IconButton(
//               icon: Icon(
//                 CupertinoIcons.back,
//                 color: MyColors.myBlack,
//                 size: 25,
//               ),
//               onPressed: () {
//                 Navigator.pop(context, false);
//               },
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Skeletonizer(
//             enabled: userModel != null,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 30.h),
//                   child: Container(
//                     width: 120.w,
//                     height: 120.h,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: MyColors.myBlue,
//                     ),
//                     child: Center(
//                       child: Icon(
//                         Icons.person,
//                         size: 80,
//                         color: MyColors.myWhite,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 30.h),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         AppTextFormField(
//                           hintText: 'Name',
//                           controller: nameController,
//                           validator: (value) =>
//                           value!.isEmpty ? 'Please enter your name' : null,
//                         ),
//                         SizedBox(height: 18.h),
//                         AppTextFormField(
//                           hintText: 'Email',
//                           controller: emailController,
//                           validator: (value) =>
//                           value!.isEmpty ? 'Please enter your email' : null,
//                         ),
//                         SizedBox(height: 18.h),
//                         AppTextFormField(
//                           hintText: 'Phone',
//                           controller: phoneController,
//                           validator: (value) =>
//                           value!.isEmpty ? 'Please enter your phone' : null,
//                         ),
//                         SizedBox(height: 18.h),
//                         AppTextFormField(
//                           hintText: 'Password',
//                           controller: passwordController,
//                           validator: (value) => value!.isEmpty
//                               ? 'Please enter your password'
//                               : null,
//                           isPassword: isObscure,
//                           suffixIcon: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 isObscure = !isObscure;
//                               });
//                             },
//                             child: Icon(
//                               isObscure ? Icons.visibility_off : Icons.visibility,
//                               color: MyColors.myGrey,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 18.h),
//                         AppTextFormField(

//                           hintText: 'Confirm Password',
//                           controller: confirmPasswordController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please confirm your password';
//                             }
//                             if (value != passwordController.text) {
//                               return 'Passwords do not match';
//                             }
//                             return null;

//                           },
//                           isPassword: isObscure,
//                           suffixIcon: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 isObscure = !isObscure;
//                               });
//                             },
//                             child: Icon(
//                               isObscure ? Icons.visibility_off : Icons.visibility,
//                               color: MyColors.myGrey,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 30.h),
//                         isLoading
//                             ? CircularProgressIndicator(
//                           color: MyColors.myBlue,
//                           strokeWidth: 2,
//                         )
//                             : AppTextButton(
//                           buttonText: 'Save',
//                           textStyle: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: MyColors.myWhite,
//                           ),
//                           onPressed: updateProfile,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
