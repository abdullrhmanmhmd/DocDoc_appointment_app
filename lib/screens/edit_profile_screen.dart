import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/core/network/api_error.dart';
import 'package:docdoc/logic/auth/auth_repo.dart';
import 'package:docdoc/logic/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:docdoc/ui/widgets/app_text_button.dart';
import 'package:docdoc/ui/widgets/app_text_form_field.dart';
import 'package:docdoc/ui/widgets/custom_snack.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // Form key
  final formKey = GlobalKey<FormState>();

  // States
  bool isObscure = true;
  bool isLoading = false;
  UserModel? userModel;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  // Repository
  final AuthRepo authRepo = AuthRepo();
