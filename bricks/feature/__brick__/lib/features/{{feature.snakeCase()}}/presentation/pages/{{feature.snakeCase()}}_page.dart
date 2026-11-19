import 'dart:async';

import 'package:base_flutter/core/l10n/failure_message.dart';
import 'package:base_flutter/core/widgets/status_views.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/presentation/cubit/{{feature.snakeCase()}}_cubit.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class {{feature.pascalCase()}}Page extends StatefulWidget {
  const {{feature.pascalCase()}}Page({super.key});

  @override
  State<{{feature.pascalCase()}}Page> createState() => _{{feature.pascalCase()}}PageState();
}

class _{{feature.pascalCase()}}PageState extends State<{{feature.pascalCase()}}Page> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<{{feature.pascalCase()}}Cubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      // TODO(team): add a translation key for the title.
      appBar: AppBar(title: const Text('{{feature.titleCase()}}')),
      body: BlocBuilder<{{feature.pascalCase()}}Cubit, {{feature.pascalCase()}}State>(
        builder: (context, state) => switch (state) {
          {{feature.pascalCase()}}Initial() || {{feature.pascalCase()}}Loading() => const LoadingView(),
          {{feature.pascalCase()}}Failure(:final failure) => FailureView(
            message: failure.message(t),
            onRetry: () => context.read<{{feature.pascalCase()}}Cubit>().load(),
          ),
          {{feature.pascalCase()}}Loaded(:final items) when items.isEmpty => MessageView(
            icon: Icons.inbox_outlined,
            message: t.no_data,
          ),
          {{feature.pascalCase()}}Loaded(:final items) => RefreshIndicator(
            onRefresh: () => context.read<{{feature.pascalCase()}}Cubit>().load(),
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, index) => ListTile(title: Text(items[index].title)),
            ),
          ),
        },
      ),
    );
  }
}
