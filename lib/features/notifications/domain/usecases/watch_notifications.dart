import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/domain/repositories/notification_repository.dart';

class WatchNotifications {
  const WatchNotifications(this._repository);

  final NotificationRepository _repository;

  Stream<List<AppNotification>> call() => _repository.watchAll();
}
