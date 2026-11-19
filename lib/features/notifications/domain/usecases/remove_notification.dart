import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/notifications/domain/repositories/notification_repository.dart';

class RemoveNotification {
  const RemoveNotification(this._repository);

  final NotificationRepository _repository;

  Future<Result<void>> call(String id) => _repository.remove(id);
}
