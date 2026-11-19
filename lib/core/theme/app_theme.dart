import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';

/// Light and dark themes. Widgets read colors and text styles from
/// `Theme.of(context)` so both modes stay consistent.
///
/// To use a custom font, declare it under `flutter: fonts:` in pubspec.yaml
/// and pass `fontFamily` to both themes below.
abstract final class AppTheme {
  static const FlexScheme _scheme = FlexScheme.deepBlue;

  static const _subThemes = FlexSubThemesData(
    useMaterial3Typography: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
  );

  static ThemeData light() => FlexThemeData.light(
    scheme: _scheme,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: _subThemes.copyWith(blendOnLevel: 10),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );

  static ThemeData dark() => FlexThemeData.dark(
    scheme: _scheme,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    subThemesData: _subThemes.copyWith(blendOnLevel: 20),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );
}
