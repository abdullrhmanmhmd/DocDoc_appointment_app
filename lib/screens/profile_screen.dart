import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/core/network/api_error.dart';
import 'package:docdoc/logic/auth/auth_repo.dart';
import 'package:docdoc/logic/models/user_model.dart';
// import 'package:docdoc/logic/auth/user_model.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(customSnack(error ?? 'Error'));
    }
  }

  Future<void> logout() async {
    setState(() => isLoading = true);
    await authRepo.logout();
    setState(() => isLoading = false);
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 60,
      onRefresh: () async {
        FocusScope.of(context).unfocus();
        await getProfileData();
      },
      color: MyColors.myBlue,
      backgroundColor: MyColors.myWhite,
      child: Skeletonizer(
        enabled: userModel == null,
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
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.back,
                  color: MyColors.myWhite,
                  size: 25.sp,
                ),
                onPressed: () {},
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 16),
                child: Icon(
                  CupertinoIcons.gear_alt_fill,
                  color: MyColors.myWhite,
                  size: 25.sp,
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
                      topLeft: Radius.circular(25.sp),
                      topRight: Radius.circular(25.sp),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 42.h,),

                    width: 130.w,
                    height: 130.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromRGBO(230, 219, 255, 1.0),
                      border: Border.all(color: MyColors.myWhite, width: 6.w),
                    ),
                    child: Icon(
                      Icons.person,
                      color: MyColors.myWhite,
                      size: 80.sp,
                    ),
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
                          userModel?.name ?? 'Loading..',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: MyColors.myBlack,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Text(
                          userModel?.email ?? 'Loading..',
                          style: TextStyle(
                            fontSize: 16.sp,
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
                            borderRadius: BorderRadius.circular(16.sp),
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
                                        fontSize: 14.sp,
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
                                        fontSize: 14.sp,
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
                            // backgroundColor: MyColors.myBlue,
                            child: SvgPicture.asset("assets/svgs/Icon (1).svg"),
                          ),
                          SizedBox(width: 16.w),
                          Text("Personal Information",style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: MyColors.myBlack,
                          ),)
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: MyColors.myLightGrey,
                      ),
                      SizedBox(height: 16.h),
                      Row(children: [
                        CircleAvatar(
                          radius: 20.r,
                          // backgroundColor: MyColors.myBlue,
                          child: SvgPicture.asset("assets/svgs/Icon (2).svg"),
                        ),
                        SizedBox(width: 16.w),
                        Text("My Test & Diagnostic",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: MyColors.myBlack,
                        ),)
                      ]),
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: MyColors.myLightGrey,
                      ),
                      SizedBox(height: 16.h),
                      Row(children: [
                        CircleAvatar(
                          radius: 20.r,
                          // backgroundColor: MyColors.myBlue,
                          child: SvgPicture.asset("assets/svgs/Icon (3).svg"),
                        ),
                        SizedBox(width: 16.w),
                        Text("Payment",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: MyColors.myBlack,
                        ),)
                      ]),
                      SizedBox(height: 29.h),
                      // Container(
                      //   width: double.infinity,
                      //   height: 1,
                      //   color: MyColors.myLightGrey,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Edit Profile Button
                          Expanded(
                            child: Container(
                              height: 55.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.sp),
                                color: MyColors.myBlue,
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                ),
                                onPressed: () async {
                                  final updated = await Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateProfileScreen(),
                                    ),
                                  );
                                  if (updated == true) {
                                    await getProfileData();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        color: MyColors.myWhite,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Icon(
                                      CupertinoIcons.pencil,
                                      color: MyColors.myWhite,
                                      size: 22.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12.w),

                          // Log Out Button
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
                                  width: 0.8.sp,
                                ),
                                borderRadius: BorderRadius.circular(
                                  16.sp,
                                ),
                                color: MyColors.myWhite,
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                ),
                                onPressed: logout,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Log Out',
                                      style: TextStyle(
                                        color: MyColors.myBlue,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Icon(
                                      Icons.logout,
                                      color: MyColors.myBlue,
                                      size: 22.sp,
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
      ),
    );
  }
}
