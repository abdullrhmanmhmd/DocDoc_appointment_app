
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/logic/models/user_model.dart';
import 'package:doc_app_sw/screens/home_screen.dart';
import 'package:doc_app_sw/screens/my_appointments_screen.dart';
import 'package:doc_app_sw/screens/profile_screen.dart';
import 'package:doc_app_sw/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationWidget extends StatefulWidget {
  // final UserModel userModel;

  const BottomNavigationWidget({super.key, required UserModel userModel});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int currentScreen = 0;
  late PageController pageController;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentScreen);

    screens = [
      HomeScreen(doctors: [],),
      const SearchScreen(doctors: [],),
       MyAppointmentsScreen(),
       ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentScreen = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: MyColors.myWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.sp),
            topRight: Radius.circular(25.sp),
          ),
          border: Border.all(color: MyColors.myGrey.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(10),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            iconSize: 25.sp,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            backgroundColor: Colors.black.withOpacity(0.0),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: MyColors.myBlue,
            unselectedItemColor: MyColors.myGrey,
            currentIndex: currentScreen,
            onTap: (index) {
              setState(() {
                currentScreen = index;
              });
              pageController.jumpToPage(index);
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Appointments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

