import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

enum NotificationType { info, warning, error }

@JsonSerializable()
class NotificationModel {
  final String title;
  final String message;
  final NotificationType type;
  bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.message,
    required this.type,
    this.isRead = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
