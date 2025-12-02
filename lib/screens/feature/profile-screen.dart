import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/core/network/api_error.dart';
import 'package:docdoc/logic/auth/auth_repo.dart';
import 'package:docdoc/logic/models/user_model.dart';
import 'package:docdoc/ui/login/login_screen.dart';
import 'package:docdoc/ui/profile/update_profile_screen.dart';
import 'package:docdoc/ui/profile/widgets/profile_text_field.dart';
import 'package:docdoc/ui/widgets/custom_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  UserModel? userModel;

  final AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfile();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String? error;
      if (e is ApiError) error = e.massage;
      ScaffoldMessenger.of(context).showSnackBar(
        customSnack(error ?? 'Error'),
      );
    }
  }

  Future<void> logout() async {
    setState(() => isLoading = true);
    await authRepo.logout();
    setState(() => isLoading = false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
