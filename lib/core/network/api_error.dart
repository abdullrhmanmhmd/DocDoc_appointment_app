class ApiError {
  final String massage;
  final int? statusCode;

  ApiError({required this.massage, this.statusCode});

  @override
  String toString() {
    return massage;
  }
}
