
import 'package:dio/dio.dart';
import 'package:doc_app_sw/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    String message = 'Something went wrong';

    if (error.type == DioExceptionType.badResponse) {
      final data = error.response?.data;

      if (data is Map) {
        if (data['data'] != null && data['data'] is Map) {
          final errorsMap = data['data'] as Map;
          final errorMessages = <String>[];

          errorsMap.forEach((key, value) {
            if (value is List) {
              errorMessages.addAll(value.map((e) => e.toString()));
            } else {
              errorMessages.add(value.toString());
            }
          });
          message = errorMessages.join('\n');
        } else if (data['message'] != null) {
          message = data['message'];
        }
      } else {
        message = 'Bad response: ${error.response?.statusCode}';
      }
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          message = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          message = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          message = 'Receive timeout';
          break;
        case DioExceptionType.badCertificate:
          message = 'Bad certificate';
          break;
        case DioExceptionType.connectionError:
          message = 'Connection error';
          break;
        case DioExceptionType.unknown:
          message = 'Unknown error: ${error.message}';
          break;
        default:
          message = 'Unexpected error';
      }
    }

    print('🔴 API ERROR: $message');
    return ApiError(massage: message);

  }
}
