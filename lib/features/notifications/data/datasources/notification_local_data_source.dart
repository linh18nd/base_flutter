import 'dart:async';

import 'package:base_flutter/features/notifications/data/models/notification_model.dart';

/// In-memory store. Swap for a database or push-notification backed source
/// without touching domain or presentation.
final class NotificationLocalDataSource {
  NotificationLocalDataSource({List<NotificationModel> seed = const []})
    : _items = List.unmodifiable(seed);

  List<NotificationModel> _items;
  final _changes = StreamController<List<NotificationModel>>.broadcast();

  Stream<List<NotificationModel>> watch() async* {
    yield _items;
    yield* _changes.stream;
  }

  Future<void> update(
    List<NotificationModel> Function(List<NotificationModel> items) change,
  ) async {
    _items = List.unmodifiable(change(_items));
    _changes.add(_items);
  }

  Future<void> dispose() => _changes.close();
}
