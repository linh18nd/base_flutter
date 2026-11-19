import 'package:base_flutter/features/notifications/data/datasources/notification_local_data_source.dart';
import 'package:base_flutter/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/domain/repositories/notification_repository.dart';
import 'package:base_flutter/features/notifications/domain/usecases/notification_usecases.dart';
import 'package:base_flutter/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:get_it/get_it.dart';

/// [seed] provides the initial items (demo data for now). It is resolved
/// lazily, after the locale has been set during bootstrap.
void registerNotificationsFeature(
  GetIt getIt, {
  required List<AppNotification> Function() seed,
}) {
  getIt
    // Data
    ..registerLazySingleton(
      () => NotificationLocalDataSource(seed: seed()),
      dispose: (source) => source.dispose(),
    )
    ..registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(getIt()),
    )
    // Domain
    ..registerFactory(() => WatchNotifications(getIt()))
    ..registerFactory(() => MarkNotificationAsRead(getIt()))
    ..registerFactory(() => RemoveNotification(getIt()))
    ..registerFactory(() => ClearNotifications(getIt()))
    // Presentation
    ..registerFactory(
      () => NotificationsCubit(
        watchNotifications: getIt(),
        markAsRead: getIt(),
        removeNotification: getIt(),
        clearNotifications: getIt(),
      ),
    );
}
