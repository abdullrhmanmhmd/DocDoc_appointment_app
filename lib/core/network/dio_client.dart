import 'package:dio/dio.dart';
import 'package:doc_app_sw/core/utils/pref_helper.dart';
class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://vcare.integration25.com/api/',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
