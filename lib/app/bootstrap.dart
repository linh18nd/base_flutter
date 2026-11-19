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

/// Initializes everything before the first frame, then runs the app.
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

  final env = AppEnv.current();
  appLogger.i('Starting $env');
  if (kDebugMode && appFlavor == null) {
    appLogger.w(
      'No --flavor given, using dev. Run with --flavor dev|stag|prod.',
    );
  }

  Bloc.observer = AppBlocObserver(appLogger);
  await configureDependencies(env);

  final settings = switch (await getIt<GetSettings>()()) {
    Ok(:final value) => value,
    Err() => const AppSettings(),
  };
  if (settings.languageCode case final code?) {
    await LocaleSettings.setLocaleRaw(code);
  } else {
    await LocaleSettings.useDeviceLocale();
  }

  runApp(TranslationProvider(child: App(initialSettings: settings)));
}
