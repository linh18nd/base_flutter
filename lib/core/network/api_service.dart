import 'package:dio/dio.dart';

import 'package:base_flutter/core/network/api_client.dart';
import 'package:base_flutter/core/network/app_exception.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';

abstract class ApiService {
  ApiService(this.apiClient);

  final ApiClient apiClient;

  /// Runs [call] and converts the response body with [parse].
  ///
  /// Returns the parsed value on success and throws [AppException] on any
  /// failure (network, non-2xx status, or unexpected response shape).
  Future<T> request<T>(
    Future<Response<dynamic>> Function() call,
    T Function(dynamic data) parse,
  ) async {
    final Response<dynamic> response;
    try {
      response = await call();
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    }

    try {
      return parse(response.data);
    } catch (e) {
      throw AppException(
        t.error_parsing_response,
        statusCode: response.statusCode,
        cause: e,
      );
    }
  }
}
