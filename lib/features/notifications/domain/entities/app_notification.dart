import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

enum NotificationType { info, warning, error }

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String title,
    required String message,
    required NotificationType type,
    required DateTime createdAt,
    @Default(false) bool isRead,
  }) = _AppNotification;
}
