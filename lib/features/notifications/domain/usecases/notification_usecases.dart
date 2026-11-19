import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/domain/repositories/notification_repository.dart';

class WatchNotifications {
  const WatchNotifications(this._repository);

  final NotificationRepository _repository;

  Stream<List<AppNotification>> call() => _repository.watchAll();
}

class MarkNotificationAsRead {
  const MarkNotificationAsRead(this._repository);

  final NotificationRepository _repository;

  Future<void> call(String id) => _repository.markAsRead(id);
}

class RemoveNotification {
  const RemoveNotification(this._repository);

  final NotificationRepository _repository;

  Future<void> call(String id) => _repository.remove(id);
}

class ClearNotifications {
  const ClearNotifications(this._repository);

  final NotificationRepository _repository;

  Future<void> call() => _repository.clearAll();
}
