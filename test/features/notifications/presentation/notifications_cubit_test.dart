import 'package:base_flutter/features/notifications/data/datasources/notification_local_data_source.dart';
import 'package:base_flutter/features/notifications/data/models/notification_model.dart';
import 'package:base_flutter/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/domain/usecases/clear_notifications.dart';
import 'package:base_flutter/features/notifications/domain/usecases/mark_notification_as_read.dart';
import 'package:base_flutter/features/notifications/domain/usecases/remove_notification.dart';
import 'package:base_flutter/features/notifications/domain/usecases/watch_notifications.dart';
import 'package:base_flutter/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wires the real repository and in-memory data source to check the whole
/// feature end to end.
void main() {
  late NotificationLocalDataSource source;
  late NotificationsCubit cubit;

  NotificationModel item(String id) => NotificationModel(
    id: id,
    title: 'Title $id',
    message: 'Message $id',
    type: NotificationType.info,
    createdAt: DateTime(2026),
  );

  setUp(() async {
    source = NotificationLocalDataSource(seed: [item('a'), item('b')]);
    final repository = NotificationRepositoryImpl(source);
    cubit = NotificationsCubit(
      watchNotifications: WatchNotifications(repository),
      markNotificationAsRead: MarkNotificationAsRead(repository),
      removeNotification: RemoveNotification(repository),
      clearNotifications: ClearNotifications(repository),
    );
    await pumpEventQueue();
  });

  tearDown(() async {
    await cubit.close();
    await source.dispose();
  });

  test('loads seeded items and counts unread', () {
    expect(cubit.state.items.map((n) => n.id), ['a', 'b']);
    expect(cubit.state.unreadCount, 2);
  });

  test('markAsRead decreases the unread count', () async {
    await cubit.markAsRead('a');
    await pumpEventQueue();
    expect(cubit.state.unreadCount, 1);
  });

  test('remove and clearAll update the list', () async {
    await cubit.remove('a');
    await pumpEventQueue();
    expect(cubit.state.items.map((n) => n.id), ['b']);

    await cubit.clearAll();
    await pumpEventQueue();
    expect(cubit.state.items, isEmpty);
  });
}
