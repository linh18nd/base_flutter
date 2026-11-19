/// Dependency rules between the top-level folders of `lib/`:
///
/// ```text
/// app ──▶ features ──▶ shared ──▶ core
/// ```
///
/// - `core/`     imports only `core/` and `i18n/`.
/// - `shared/`   imports `core/`, `i18n/` and other `shared/` modules.
/// - `features/x/` imports `core/`, `i18n/`, `shared/`, its own feature and
///   `app/router/routes.dart` (route paths, for navigation) — never another
///   feature or the rest of `app/`.
/// - `domain/` (in a feature or shared module) stays Flutter-free: only
///   `dart:*`, `freezed_annotation`, `meta`, `core/error/`, its own
///   module's `domain/` and the `domain/` of any `shared/` module.
/// - `data/` never imports `presentation/`.
/// - `presentation/` never imports `data/` or repository interfaces
///   (`domain/repositories/`): it goes through usecases.
library;

const _pkg = 'package:base_flutter/';

const _allowedDomainPackages = ['package:freezed_annotation/', 'package:meta/'];

/// Returns a description of each rule [import] breaks when it appears in
/// [file] (a path relative to the project root, e.g. `lib/core/x.dart`).
List<String> importViolations(String file, String import) {
  final source = _Location.parse(file.replaceFirst('lib/', ''));
  final violations = <String>[];

  if (source.isDomain && !_isAllowedInDomain(source, import)) {
    violations.add('domain must stay Flutter/infra-free');
  }

  if (!import.startsWith(_pkg)) return violations;
  final target = _Location.parse(import.substring(_pkg.length));

  switch (source.layer) {
    case 'core':
      if (!{'core', 'i18n'}.contains(target.layer)) {
        violations.add('core/ may only import core/ and i18n/');
      }
    case 'shared':
      if (!{'core', 'i18n', 'shared'}.contains(target.layer)) {
        violations.add('shared/ may only import core/, i18n/ and shared/');
      }
    case 'features':
      final isRoutes = target.path == 'app/router/routes.dart';
      if (target.layer == 'app' && !isRoutes) {
        violations.add('features may only import app/router/routes.dart');
      }
      if (target.layer == 'features' && target.module != source.module) {
        violations.add(
          'feature "${source.module}" must not import feature '
          '"${target.module}"; move shared code to shared/ or core/',
        );
      }
  }

  final sameModule =
      source.layer == target.layer && source.module == target.module;
  if (sameModule &&
      source.subLayer == 'data' &&
      target.subLayer == 'presentation') {
    violations.add('data/ must not import presentation/');
  }

  if (source.subLayer == 'presentation') {
    if (target.subLayer == 'data') {
      violations.add('presentation/ must not import data/; use a usecase');
    }
    if (target.isRepositoryInterface) {
      violations.add(
        'presentation/ must not use repositories directly; use a usecase',
      );
    }
  }

  return violations;
}

bool _isAllowedInDomain(_Location source, String import) {
  if (import.startsWith('dart:')) return true;
  if (_allowedDomainPackages.any(import.startsWith)) return true;
  if (!import.startsWith(_pkg)) return false;
  final target = _Location.parse(import.substring(_pkg.length));
  if (target.path.startsWith('core/error/')) return true;
  if (!target.isDomain) return false;
  // Shared entities (e.g. a `User` inside an `Order`) are the point of
  // shared/, so any domain may use them.
  if (target.layer == 'shared') return true;
  return target.layer == source.layer && target.module == source.module;
}

/// A path inside `lib/`, split into layer / module / sub-layer.
/// `features/posts/domain/x.dart` → layer `features`, module `posts`,
/// sub-layer `domain`.
class _Location {
  const _Location(this.path, this.layer, this.module, this.subLayer);

  factory _Location.parse(String path) {
    final parts = path.split('/');
    final layer = parts.first;
    final hasModule = layer == 'features' || layer == 'shared';
    return _Location(
      path,
      layer,
      hasModule && parts.length > 1 ? parts[1] : null,
      hasModule && parts.length > 2 ? parts[2] : null,
    );
  }

  final String path;
  final String layer;
  final String? module;
  final String? subLayer;

  bool get isDomain => subLayer == 'domain';

  bool get isRepositoryInterface =>
      isDomain && path.contains('/domain/repositories/');
}
