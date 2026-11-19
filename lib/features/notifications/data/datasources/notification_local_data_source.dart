import 'dart:async';

import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';

/// In-memory store. Swap for a database or push-notification backed source
/// without touching domain or presentation.
final class NotificationLocalDataSource {
  NotificationLocalDataSource({List<AppNotification> seed = const []})
    : _items = List.unmodifiable(seed);

  List<AppNotification> _items;
  final _changes = StreamController<List<AppNotification>>.broadcast();

  Stream<List<AppNotification>> watch() async* {
    yield _items;
    yield* _changes.stream;
  }

  void update(
    List<AppNotification> Function(List<AppNotification> items) change,
  ) {
    _items = List.unmodifiable(change(_items));
    _changes.add(_items);
  }

  Future<void> dispose() => _changes.close();
}
