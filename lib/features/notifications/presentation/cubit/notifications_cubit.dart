import 'dart:async';

import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/domain/usecases/notification_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_cubit.freezed.dart';

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(<AppNotification>[]) List<AppNotification> items,
  }) = _NotificationsState;

  const NotificationsState._();

  int get unreadCount => items.where((n) => !n.isRead).length;
}

/// App-level cubit: the notifications tab and the navigation badge share it.
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({
    required WatchNotifications watchNotifications,
    required this._markAsRead,
    required RemoveNotification removeNotification,
    required ClearNotifications clearNotifications,
  }) : _remove = removeNotification,
       _clear = clearNotifications,
       super(const NotificationsState()) {
    _subscription = watchNotifications().listen(
      (items) => emit(state.copyWith(items: items)),
    );
  }

  final MarkNotificationAsRead _markAsRead;
  final RemoveNotification _remove;
  final ClearNotifications _clear;
  late final StreamSubscription<List<AppNotification>> _subscription;

  Future<void> markAsRead(String id) => _markAsRead(id);

  Future<void> remove(String id) => _remove(id);

  Future<void> clearAll() => _clear();

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}
