import 'package:flutter/material.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';

extension LocalizationExtension on BuildContext {
  Translations get l10n => Translations.of(this);
}
