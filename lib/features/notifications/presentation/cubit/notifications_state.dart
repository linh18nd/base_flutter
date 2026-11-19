part of 'notifications_cubit.dart';

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(<AppNotification>[]) List<AppNotification> items,
  }) = _NotificationsState;

  const NotificationsState._();

  int get unreadCount => items.where((n) => !n.isRead).length;
}
