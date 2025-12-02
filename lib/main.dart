import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
  //tesing
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}
