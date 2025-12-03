import 'package:dio/dio.dart';
import 'package:doc_app_sw/core/network/api_error.dart';
import 'package:doc_app_sw/core/network/api_exceptions.dart';
import 'package:doc_app_sw/core/network/api_services.dart';
import 'package:doc_app_sw/core/utils/pref_helper.dart';
import 'package:doc_app_sw/logic/models/user_model.dart';

class AuthRepo {
  final ApiServices apiServices = ApiServices();
  UserModel _currentUser = UserModel();
  UserModel get currentUser => _currentUser;


  ///login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiServices.post('auth/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      final user = UserModel.fromJson(response['data']);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
  Future<UserModel?> getProfile() async {
    try {
      final response = await apiServices.get('user/profile');

      if (response is ApiError) {
        throw response;
      }
      final data = response['data'];
      final userJson = (data is List && data.isNotEmpty) ? data.first : data;
      return UserModel.fromJson(userJson);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(massage: e.toString());
    }
  }

}///Get Profile Data
Future<UserModel?> getProfile() async {
  try {
    final response = await apiServices.get('user/profile');

    if (response is ApiError) {
      throw response;
    }
    final data = response['data'];
    final userJson = (data is List && data.isNotEmpty) ? data.first : data;
    return UserModel.fromJson(userJson);
  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
  } catch (e) {
    throw ApiError(massage: e.toString());
  }
}
