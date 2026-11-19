import 'dart:async';

import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/logger/app_logger.dart';
import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/domain/usecases/clear_notifications.dart';
import 'package:base_flutter/features/notifications/domain/usecases/mark_notification_as_read.dart';
import 'package:base_flutter/features/notifications/domain/usecases/remove_notification.dart';
import 'package:base_flutter/features/notifications/domain/usecases/watch_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_cubit.freezed.dart';
part 'notifications_state.dart';

/// App-level cubit: the notifications tab and the navigation badge share it.
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({
    required WatchNotifications watchNotifications,
    required this._markNotificationAsRead,
    required this._removeNotification,
    required this._clearNotifications,
  }) : super(const NotificationsState()) {
    _subscription = watchNotifications().listen(
      (items) => emit(state.copyWith(items: items)),
    );
  }

  final MarkNotificationAsRead _markNotificationAsRead;
  final RemoveNotification _removeNotification;
  final ClearNotifications _clearNotifications;
  late final StreamSubscription<List<AppNotification>> _subscription;

  // The list itself updates through the stream; a failed change is only
  // logged because the UI keeps showing the last known list.
  Future<void> markAsRead(String id) async =>
      _logIfFailed(await _markNotificationAsRead(id));

  Future<void> remove(String id) async =>
      _logIfFailed(await _removeNotification(id));

  Future<void> clearAll() async => _logIfFailed(await _clearNotifications());

  void _logIfFailed(Result<void> result) {
    if (result case Err(:final failure)) {
      appLogger.w('Notification change failed: $failure');
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}
