import 'package:base_flutter/features/notifications/data/datasources/notification_local_data_source.dart';
import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/domain/repositories/notification_repository.dart';

final class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._local);

  final NotificationLocalDataSource _local;

  @override
  Stream<List<AppNotification>> watchAll() => _local.watch();

  @override
  Future<void> markAsRead(String id) async => _local.update(
    (items) => [
      for (final n in items)
        if (n.id == id) n.copyWith(isRead: true) else n,
    ],
  );

  @override
  Future<void> remove(String id) async =>
      _local.update((items) => items.where((n) => n.id != id).toList());

  @override
  Future<void> clearAll() async => _local.update((_) => const []);
}
