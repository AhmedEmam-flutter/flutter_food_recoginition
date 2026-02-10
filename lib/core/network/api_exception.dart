import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDio(DioException e) {
    final data = e.response?.data;

    if (data is Map) {
      final errors = data["errors"];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        if (first is List && first.isNotEmpty) {
          return ApiException(first.first.toString());
        }
      }

      final msg = data["message"] ?? data["error"] ?? data["title"];
      if (msg is String && msg.isNotEmpty) {
        return ApiException(msg);
      }
    }

    if (data is String && data.isNotEmpty) {
      return ApiException(data);
    }

    return ApiException(e.message ?? "Network error");
  }

  @override
  String toString() => message;
}
