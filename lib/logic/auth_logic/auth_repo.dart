import 'package:dio/dio.dart';
import 'package:doc_app_sw/core/network/api_error.dart';
import 'package:doc_app_sw/core/network/api_exceptions.dart';
import 'package:doc_app_sw/core/network/api_services.dart';
import 'package:doc_app_sw/core/utils/pref_helper.dart';
import 'package:doc_app_sw/logic/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final ApiServices apiServices = ApiServices();
  UserModel _currentUser = UserModel();
  UserModel get currentUser => _currentUser;

  ///signup
  Future<void> signup(String name, String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );

    await userCredential.user?.updateDisplayName(name.trim());
  }

  ///login
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }


///get profile
Future<User?> getProfileData() async {
  try {
    return FirebaseAuth.instance.currentUser;
  } catch (e) {
    throw ApiError(massage: 'Failed to get user data.');
  }
}

