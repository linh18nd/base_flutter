part of 'settings_cubit.dart';

/// Presentation state. Wraps the domain [AppSettings] so UI-only fields
/// (saving flags, errors…) can be added later without touching the domain.
@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({@Default(AppSettings()) AppSettings settings}) =
      _SettingsState;
}
