import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/domain/usecases/settings_usecases.dart';
import 'package:base_flutter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUpdateThemeMode extends Mock implements UpdateThemeMode;

class _MockUpdateLanguage extends Mock implements UpdateLanguage;

void main() {
  late _MockUpdateThemeMode updateThemeMode;
  late _MockUpdateLanguage updateLanguage;

  setUpAll(() => registerFallbackValue(AppThemeMode.system));

  setUp(() {
    updateThemeMode = _MockUpdateThemeMode();
    updateLanguage = _MockUpdateLanguage();
    when(() => updateThemeMode(any())).thenAnswer((_) async => const Ok(null));
    when(() => updateLanguage(any())).thenAnswer((_) async => const Ok(null));
  });

  SettingsCubit build([AppSettings initial = const AppSettings()]) =>
      SettingsCubit(
        initial: initial,
        updateThemeMode: updateThemeMode,
        updateLanguage: updateLanguage,
      );

  blocTest<SettingsCubit, AppSettings>(
    'setThemeMode updates state and persists it',
    build: build,
    act: (cubit) => cubit.setThemeMode(AppThemeMode.dark),
    expect: () => const [AppSettings(themeMode: AppThemeMode.dark)],
    verify: (_) => verify(() => updateThemeMode(AppThemeMode.dark)).called(1),
  );

  blocTest<SettingsCubit, AppSettings>(
    'setThemeMode with the current mode does nothing',
    build: build,
    act: (cubit) => cubit.setThemeMode(AppThemeMode.system),
    expect: () => const <AppSettings>[],
    verify: (_) => verifyNever(() => updateThemeMode(any())),
  );

  blocTest<SettingsCubit, AppSettings>(
    'keeps the new language even if saving fails',
    setUp: () =>
        when(() => updateLanguage(any()))
            .thenAnswer((_) async => const Err(StorageFailure())),
    build: build,
    act: (cubit) => cubit.setLanguage('en'),
    expect: () => const [AppSettings(languageCode: 'en')],
  );
}
