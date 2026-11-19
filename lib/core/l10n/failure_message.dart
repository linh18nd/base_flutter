import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';

/// Turns a [Failure] into localized, user-facing text.
extension FailureMessage on Failure {
  String message(Translations t) => switch (this) {
    NetworkFailure() => t.connection_error,
    TimeoutFailure() => t.connection_timeout,
    ServerFailure(:final message) => message ?? t.server_error,
    UnauthorizedFailure() => t.unauthorized,
    CancelledFailure() => t.request_cancelled,
    ParsingFailure() => t.error_parsing_response,
    StorageFailure() => t.storage_error,
    UnknownFailure() => t.an_error_occurred,
  };
}
