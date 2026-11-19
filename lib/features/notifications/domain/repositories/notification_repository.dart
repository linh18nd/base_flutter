import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';

abstract interface class NotificationRepository {
  /// Emits the current list immediately, then every change.
  ///
  /// Streams are the one exception to "return `Result`": they report data
  /// over time, and the operations that change that data return `Result`.
  Stream<List<AppNotification>> watchAll();

  Future<Result<void>> markAsRead(String id);

  Future<Result<void>> remove(String id);

  Future<Result<void>> clearAll();
}
