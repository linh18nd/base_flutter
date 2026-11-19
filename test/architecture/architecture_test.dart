import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'import_rules.dart';

final _importPattern = RegExp(r'''^import\s+['"]([^'"]+)['"]''');

void main() {
  test('lib/ follows the dependency rules', () {
    final violations = <String>[];

    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .map((f) => f.path)
        .where(
          (p) =>
              p.endsWith('.dart') &&
              !p.endsWith('.g.dart') &&
              !p.endsWith('.freezed.dart') &&
              !p.startsWith('lib/i18n/gen/'),
        );

    for (final path in files) {
      for (final line in File(path).readAsLinesSync()) {
        final import = _importPattern.firstMatch(line)?.group(1);
        if (import == null) continue;
        for (final rule in importViolations(path, import)) {
          violations.add('$path\n  imports $import\n  → $rule');
        }
      }
    }

    expect(violations, isEmpty, reason: '\n${violations.join('\n\n')}');
  });

  group('importViolations', () {
    test('allows a feature to use core, shared and its own files', () {
      for (final import in [
        'package:base_flutter/core/error/result.dart',
        'package:base_flutter/shared/users/domain/entities/user.dart',
        'package:base_flutter/features/posts/domain/entities/post.dart',
        'package:base_flutter/app/router/routes.dart',
      ]) {
        expect(
          importViolations('lib/features/posts/presentation/x.dart', import),
          isEmpty,
          reason: import,
        );
      }
    });

    test('rejects a feature importing another feature', () {
      expect(
        importViolations(
          'lib/features/posts/presentation/x.dart',
          'package:base_flutter/features/settings/domain/entities/a.dart',
        ),
        isNotEmpty,
      );
    });

    test('rejects Flutter and data imports in domain', () {
      for (final import in [
        'package:material_ui/material_ui.dart',
        'package:dio/dio.dart',
        'package:base_flutter/features/posts/data/models/post_dto.dart',
      ]) {
        expect(
          importViolations('lib/features/posts/domain/x.dart', import),
          isNotEmpty,
          reason: import,
        );
      }
    });

    test('rejects core or shared depending on features', () {
      const feature = 'package:base_flutter/features/posts/posts.dart';
      expect(importViolations('lib/core/x.dart', feature), isNotEmpty);
      expect(importViolations('lib/shared/a/data/x.dart', feature), isNotEmpty);
    });

    test('rejects data importing presentation', () {
      expect(
        importViolations(
          'lib/features/posts/data/x.dart',
          'package:base_flutter/features/posts/presentation/cubit/c.dart',
        ),
        isNotEmpty,
      );
    });

    test('rejects presentation using data or repositories directly', () {
      for (final import in [
        'package:base_flutter/features/posts/data/models/post_dto.dart',
        'package:base_flutter/features/posts/domain/repositories/r.dart',
        'package:base_flutter/shared/users/data/models/user_dto.dart',
        'package:base_flutter/shared/users/domain/repositories/r.dart',
      ]) {
        expect(
          importViolations('lib/features/posts/presentation/x.dart', import),
          isNotEmpty,
          reason: import,
        );
      }
    });

    test('allows presentation to use usecases and entities', () {
      for (final import in [
        'package:base_flutter/features/posts/domain/usecases/get_posts.dart',
        'package:base_flutter/features/posts/domain/entities/post.dart',
        'package:base_flutter/shared/users/domain/entities/user.dart',
      ]) {
        expect(
          importViolations('lib/features/posts/presentation/x.dart', import),
          isEmpty,
          reason: import,
        );
      }
    });

    test('allows any domain to use shared domain', () {
      const user = 'package:base_flutter/shared/users/domain/entities/u.dart';
      expect(
        importViolations('lib/features/orders/domain/entities/o.dart', user),
        isEmpty,
      );
      expect(
        importViolations('lib/shared/carts/domain/entities/c.dart', user),
        isEmpty,
      );
    });

    test("rejects a domain using another feature's domain", () {
      expect(
        importViolations(
          'lib/features/orders/domain/entities/o.dart',
          'package:base_flutter/features/posts/domain/entities/post.dart',
        ),
        isNotEmpty,
      );
    });
  });
}
