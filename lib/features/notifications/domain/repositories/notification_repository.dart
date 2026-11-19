import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';

abstract interface class NotificationRepository {
  /// Emits the current list immediately, then every change.
  Stream<List<AppNotification>> watchAll();

  Future<void> markAsRead(String id);

  Future<void> remove(String id);

  Future<void> clearAll();
}
