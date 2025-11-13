class ApiError {
  final String massage;
  final int? statusCode;

  ApiError({required this.massage, this.statusCode});

  String toString() {
    return '$massage';
  }
}
