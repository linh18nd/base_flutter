import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/logger/app_logger.dart';
import 'package:dio/dio.dart';

/// Wraps a **remote** call (Dio/retrofit) and converts any thrown error into
/// a typed [Failure].
///
/// Repository implementations wrap every remote data source call with this,
/// so no exception ever leaves the data layer. For local storage use
/// [guardStorage].
Future<Result<T>> guard<T>(Future<T> Function() action) async {
  try {
    return Ok(await action());
  } on DioException catch (e, stackTrace) {
    final failure = mapDioException(e);
    if (failure is! CancelledFailure) {
      appLogger.w('Request failed: $failure', error: e, stackTrace: stackTrace);
    }
    return Err(failure);
  } on FormatException catch (e, stackTrace) {
    appLogger.e('Unexpected data format', error: e, stackTrace: stackTrace);
    return Err(ParsingFailure(cause: e));
  } on Object catch (e, stackTrace) {
    // Generated JSON parsing (json_serializable/retrofit) throws TypeError
    // when the response shape is wrong; report it as a ParsingFailure.
    if (e is TypeError) {
      appLogger.e('Unexpected data shape', error: e, stackTrace: stackTrace);
      return Err(ParsingFailure(cause: e));
    }
    appLogger.e('Unexpected error', error: e, stackTrace: stackTrace);
    return Err(UnknownFailure(cause: e));
  }
}

/// Wraps a **local** read/write (shared preferences, secure storage,
/// database, in-memory store). Any error becomes a [StorageFailure].
Future<Result<T>> guardStorage<T>(Future<T> Function() action) async {
  try {
    return Ok(await action());
  } on Object catch (e, stackTrace) {
    appLogger.e('Local storage failed', error: e, stackTrace: stackTrace);
    return Err(StorageFailure(cause: e));
  }
}

Failure mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return TimeoutFailure(cause: e);
    case DioExceptionType.cancel:
      return CancelledFailure(cause: e);
    case DioExceptionType.connectionError:
      return NetworkFailure(cause: e);
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        return UnauthorizedFailure(cause: e);
      }
      return ServerFailure(
        statusCode: statusCode,
        message: _serverMessage(e.response),
        cause: e,
      );
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return e.error is TypeError || e.error is FormatException
          ? ParsingFailure(cause: e)
          : NetworkFailure(cause: e);
  }
}

String? _serverMessage(Response<dynamic>? response) {
  final dynamic data = response?.data;
  if (data is Map<String, dynamic>) {
    final dynamic message = data['message'];
    if (message is String && message.isNotEmpty) {
      return message;
    }
  }
  return null;
}
