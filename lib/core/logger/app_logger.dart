import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// App-wide logger. Verbose in debug/profile, warnings and errors only in
/// release builds.
final Logger appLogger = Logger(
  level: kReleaseMode ? Level.warning : Level.debug,
  printer: PrettyPrinter(methodCount: 0, lineLength: 100),
);
