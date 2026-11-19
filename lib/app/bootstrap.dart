import 'dart:async';

import 'package:base_flutter/app/app.dart';
import 'package:base_flutter/app/app_bloc_observer.dart';
import 'package:base_flutter/app/di/injection.dart';
import 'package:base_flutter/core/env/app_env.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/logger/app_logger.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/domain/usecases/get_settings.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

/// Entry point used by `main()`: sets up the binding and global error
/// handlers, then runs the app.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    appLogger.e(
      details.exceptionAsString(),
      error: details.exception,
      stackTrace: details.stack,
    );
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    appLogger.f('Uncaught error', error: error, stackTrace: stackTrace);
    return true;
  };

  runApp(await createApp());
}

/// Initializes everything the first frame needs (env, DI, settings, locale)
/// and returns the root widget.
///
/// Kept separate from [bootstrap] so E2E tests can build the real app
/// without `runApp`, and swap a few dependencies through
/// [overrideDependencies] (called right after normal registration), e.g.
/// a fake HTTP adapter on `Dio`.
Future<Widget> createApp({
  FutureOr<void> Function(GetIt getIt)? overrideDependencies,
}) async {
  final env = AppEnv.current();
  appLogger.i('Starting $env');
  if (kDebugMode && appFlavor == null) {
    appLogger.w(
      'No --flavor given, using dev. Run with --flavor dev|stag|prod.',
    );
  }

  Bloc.observer = AppBlocObserver(appLogger);
  // Several E2E tests may build the app in the same process.
  await getIt.reset();
  await configureDependencies(env);
  await overrideDependencies?.call(getIt);

  final settings = switch (await getIt<GetSettings>()()) {
    Ok(:final value) => value,
    Err() => const AppSettings(),
  };
  if (settings.languageCode case final code?) {
    await LocaleSettings.setLocaleRaw(code);
  } else {
    await LocaleSettings.useDeviceLocale();
  }

  return TranslationProvider(child: App(initialSettings: settings));
}
