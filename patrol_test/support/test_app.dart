import 'package:base_flutter/app/bootstrap.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_api.dart';

/// Starts the real app (same as `main()`, minus `runApp`) on a clean state,
/// with [api] (or a default [FakeApi]) instead of the network.
///
/// Returns the fake API so tests can tweak it or inspect the requests.
Future<FakeApi> pumpTestApp(PatrolIntegrationTester $, {FakeApi? api}) async {
  // Settings and tokens survive between runs on a simulator; start clean so
  // a test never depends on the previous one.
  await SharedPreferencesAsync().clear();
  await const FlutterSecureStorage().deleteAll();

  return await _pump($, api ?? FakeApi());
}

/// Simulates closing and reopening the app: everything in memory is rebuilt
/// from scratch, while saved data (settings, tokens) is kept.
Future<FakeApi> restartTestApp(PatrolIntegrationTester $, {FakeApi? api}) =>
    _pump($, api ?? FakeApi());

Future<FakeApi> _pump(PatrolIntegrationTester $, FakeApi api) async {
  final app = await createApp(
    overrideDependencies: (getIt) {
      getIt<Dio>().httpClientAdapter = api;
    },
  );
  await $.pumpWidgetAndSettle(app);
  return api;
}
