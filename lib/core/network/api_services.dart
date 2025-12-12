import 'package:dio/dio.dart';
import 'package:doc_app_sw/core/network/api_exceptions.dart';
import 'package:doc_app_sw/core/network/dio_client.dart';


class ApiServices {
  final dio = DioClient().dio;

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<dynamic> post(String endPoint,dynamic body) async {
    try {
      final response = await dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<dynamic> update(String endPoint,dynamic body) async {
    try {
      final response = await dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<dynamic> delete(String endPoint, dynamic body) async {
    try {
      final response = await dio.delete(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }
}
