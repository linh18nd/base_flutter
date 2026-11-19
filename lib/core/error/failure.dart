/// Expected, typed errors that cross layer boundaries.
///
/// Data layer converts exceptions into a [Failure]; domain and presentation
/// only ever see these types. Turning a failure into user-facing text is a
/// presentation concern (see `core/l10n/failure_message.dart`).
sealed class Failure {
  const Failure({this.cause});

  /// Original error, kept for logging only.
  final Object? cause;

  @override
  // Debug/log output only, never shown to users.
  // ignore: no_runtimetype_tostring
  String toString() => '$runtimeType(cause: $cause)';
}

/// No connection or the host could not be reached.
final class NetworkFailure extends Failure {
  const NetworkFailure({super.cause});
}

/// Connect/send/receive timeout.
final class TimeoutFailure extends Failure {
  const TimeoutFailure({super.cause});
}

/// Server answered with a non-2xx status.
final class ServerFailure extends Failure {
  const ServerFailure({this.statusCode, this.message, super.cause});

  final int? statusCode;

  /// Message returned by the server, if any.
  final String? message;
}

/// 401 - token missing, invalid or expired.
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.cause});
}

/// Request was cancelled (for example by a newer request).
final class CancelledFailure extends Failure {
  const CancelledFailure({super.cause});
}

/// Response did not match the expected shape.
final class ParsingFailure extends Failure {
  const ParsingFailure({super.cause});
}

/// Reading or writing local storage failed.
final class StorageFailure extends Failure {
  const StorageFailure({super.cause});
}

/// Anything not covered above.
final class UnknownFailure extends Failure {
  const UnknownFailure({super.cause});
}
