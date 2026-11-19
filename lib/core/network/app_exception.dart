import 'package:dio/dio.dart';

import 'package:base_flutter/i18n/gen/translations.g.dart';

/// The single error type the data layer throws.
///
/// [message] is already localized and safe to show to users; [cause] keeps the
/// original error for logging.
class AppException implements Exception {
  const AppException(this.message, {this.statusCode, this.cause});

  factory AppException.fromDio(DioException error) {
    final int? statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return AppException(
          t.connection_timeout,
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.badResponse:
        return AppException(
          _serverMessage(error.response) ?? t.server_error,
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.cancel:
        return AppException(
          t.request_cancelled,
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.connectionError:
        return AppException(
          t.connection_error,
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.unknown:
        return AppException(
          t.no_internet_connection,
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.badCertificate:
        return AppException(
          t.an_error_occurred,
          statusCode: statusCode,
          cause: error,
        );
    }
  }

  final String message;
  final int? statusCode;
  final Object? cause;

  bool get isCancelled =>
      cause is DioException &&
      (cause! as DioException).type == DioExceptionType.cancel;

  static String? _serverMessage(Response<dynamic>? response) {
    final dynamic data = response?.data;
    if (data is Map<String, dynamic>) {
      final dynamic message = data['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    final String? statusMessage = response?.statusMessage;
    return statusMessage != null && statusMessage.isNotEmpty
        ? statusMessage
        : null;
  }

  @override
  String toString() =>
      'AppException(statusCode: $statusCode, message: $message, cause: $cause)';
}
