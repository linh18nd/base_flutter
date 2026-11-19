import 'package:base_flutter/core/storage/token_storage.dart';
import 'package:dio/dio.dart';

/// Adds `Authorization` and `Accept-Language` headers, and clears the stored
/// token when the server answers 401.
final class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required this._tokenStorage, required this._languageCode});

  final TokenStorage _tokenStorage;
  final String Function() _languageCode;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.read();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept-Language'] = _languageCode();
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // TODO(team): refresh the token here and retry the request once
      // before giving up, when the backend supports refresh tokens.
      await _tokenStorage.clear();
    }
    handler.next(err);
  }
}
