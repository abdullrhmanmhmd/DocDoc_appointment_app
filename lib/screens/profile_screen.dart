import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/core/network/api_error.dart';
import 'package:doc_app_sw/logic/auth_logic/auth_repo.dart';
import 'package:doc_app_sw/screens/edit_profile_screen.dart';
import 'package:doc_app_sw/ui/login/login_screen.dart';
import 'package:doc_app_sw/widgets/custom_snack.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? firebaseUser;

  final AuthRepo authRepo = AuthRepo();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfile();
      setState(() {
        firebaseUser = user;
      });
    } catch (e) {
      String? error;
      if (e is ApiError) error = e.massage;
      print("Error fetching profile data: $e");
      ScaffoldMessenger.of(context).showSnackBar(customSnack(error ?? 'Error'));
    }
  }

  Future<void> _logout() async {
    try {
      setState(() {
        isLoading = true;
      });

      await _auth.signOut();

      setState(() {
        isLoading = false;
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      String errorMessage = 'Failed to logout';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'An error occurred';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMessage));
      }
    }
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: MyColors.myBlack,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: MyColors.myGrey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: MyColors.myGrey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _logout();
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: firebaseUser == null,
      child: Scaffold(
        backgroundColor: MyColors.myBlue,
        appBar: AppBar(
          backgroundColor: MyColors.myBlue,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Profile",
              style: TextStyle(
                color: MyColors.myWhite,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          leading: SizedBox.shrink(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 25, right: 16),
              child: Icon(
                CupertinoIcons.gear_alt_fill,
                color: MyColors.myWhite,
                size: 25,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: 375.w,
                height: 620.h,
                margin: EdgeInsets.only(top: 100.h),
                decoration: BoxDecoration(
                  color: MyColors.myWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 42.h),
                  width: 130.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(230, 219, 255, 1.0),
                    border: Border.all(color: MyColors.myWhite, width: 6.w),
                  ),
                  child: Icon(Icons.person, color: MyColors.myWhite, size: 80),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 180.h, left: 24.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        firebaseUser?.displayName ?? 'Loading..',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: MyColors.myBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: Text(
                        firebaseUser?.email ?? 'Loading..',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: MyColors.myGrey,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Center(
                      child: Container(
                        width: 330.w,
                        height: 59.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(248, 248, 248, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(248, 248, 248, 1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "My Appointment",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.myBlack,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40.h,
                                width: 2,
                                color: MyColors.myLightGrey,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Medical records",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.myBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          child: SvgPicture.asset("assets/svgs/Icon (1).svg"),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: MyColors.myBlack,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: MyColors.myLightGrey,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          child: SvgPicture.asset("assets/svgs/Icon (2).svg"),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          "My Test & Diagnostic",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: MyColors.myBlack,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: MyColors.myLightGrey,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          child: SvgPicture.asset("assets/svgs/Icon (3).svg"),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          "Payment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: MyColors.myBlack,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 29.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: MyColors.myBlue,
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfileScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      color: MyColors.myWhite,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    CupertinoIcons.pencil,
                                    color: MyColors.myWhite,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.myBlue,
                                    strokeWidth: 2,
                                    backgroundColor: MyColors.myWhite,
                                  ),
                                )
                              : Container(
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.myBlue,
                                      width: 0.8,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    color: MyColors.myWhite,
                                  ),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                        Colors.transparent,
                                      ),
                                    ),
                                    onPressed: _showLogoutConfirmation,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Log Out',
                                          style: TextStyle(
                                            color: MyColors.myBlue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Icon(
                                          Icons.logout,
                                          color: MyColors.myBlue,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
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
