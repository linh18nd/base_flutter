import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Storage/wire format of a notification. Kept separate from the
/// [AppNotification] entity so a database or push payload can change shape
/// without touching domain or presentation.
@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String title,
    required String message,
    required NotificationType type,
    required DateTime createdAt,
    @Default(false) bool isRead,
  }) = _NotificationModel;

  const NotificationModel._();

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  factory NotificationModel.fromEntity(AppNotification entity) =>
      NotificationModel(
        id: entity.id,
        title: entity.title,
        message: entity.message,
        type: entity.type,
        createdAt: entity.createdAt,
        isRead: entity.isRead,
      );

  AppNotification toEntity() => AppNotification(
    id: id,
    title: title,
    message: message,
    type: type,
    createdAt: createdAt,
    isRead: isRead,
  );
}
