import 'package:base_flutter/core/env/app_env.dart';
import 'package:base_flutter/core/network/auth_interceptor.dart';
import 'package:base_flutter/core/network/logging_interceptor.dart';
import 'package:base_flutter/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Dio createDio({
  required AppEnv env,
  required TokenStorage tokenStorage,
  required String Function() languageCode,
  required Logger logger,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: env.baseUrl,
      connectTimeout: env.timeout,
      receiveTimeout: env.timeout,
      sendTimeout: env.timeout,
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
        if (env.apiKey.isNotEmpty) 'X-API-Key': env.apiKey,
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(tokenStorage: tokenStorage, languageCode: languageCode),
    if (!env.isProd) LoggingInterceptor(logger),
  ]);

  return dio;
}
