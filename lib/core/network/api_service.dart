import 'package:dio/dio.dart';
import 'package:base_flutter/core/network/api_client.dart';
import 'package:base_flutter/core/network/api_response.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';

abstract class ApiService {
  final ApiClient apiClient;

  ApiService(this.apiClient);

  ApiResponse<T> handleResponse<T>(
    Response<dynamic> response,
    T Function(dynamic)? fromJson,
  ) {
    try {
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final data = response.data;

        if (fromJson != null && data != null) {
          return ApiResponse.success(
            data: fromJson(data),
            statusCode: response.statusCode,
          );
        }

        return ApiResponse.success(
          data: data as T?,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          message: t.request_failed,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error(
        message: '${t.error_parsing_response}: ${e.toString()}',
        error: e,
      );
    }
  }

  ApiResponse<T> handleError<T>(dynamic error) {
    if (error is DioException) {
      String message = t.an_error_occurred;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          message = t.connection_timeout;
          break;
        case DioExceptionType.badResponse:
          final dynamic data = error.response?.data;
          String? serverMessage;

          if (data is Map<String, dynamic> && data['message'] is String) {
            serverMessage = data['message'] as String;
          }

          final String? statusMessage = error.response?.statusMessage;

          message = serverMessage?.isNotEmpty == true
              ? serverMessage!
              : (statusMessage?.isNotEmpty == true
                    ? statusMessage!
                    : t.server_error);
          break;
        case DioExceptionType.cancel:
          message = t.request_cancelled;
          break;
        case DioExceptionType.connectionError:
          message = t.connection_error;
          break;
        case DioExceptionType.unknown:
          message = t.no_internet_connection;
          break;
        default:
          message = t.an_error_occurred;
      }

      return ApiResponse.error(
        message: message,
        statusCode: error.response?.statusCode,
        error: error,
      );
    }

    return ApiResponse.error(message: error.toString(), error: error);
  }
}
