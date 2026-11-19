import 'package:base_flutter/app/router/routes.dart';
import 'package:base_flutter/core/l10n/failure_message.dart';
import 'package:base_flutter/core/widgets/status_views.dart';
import 'package:base_flutter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:base_flutter/features/posts/presentation/widgets/post_tile.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: t.search,
            onPressed: () => context.go(Routes.search),
          ),
        ],
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) => switch (state) {
          PostsInitial() => _LoadPrompt(
            onLoad: () => context.read<PostsCubit>().load(),
          ),
          PostsLoading() => const LoadingView(),
          PostsFailure(:final failure) => FailureView(
            message: failure.message(t),
            onRetry: () => context.read<PostsCubit>().load(),
          ),
          PostsLoaded(:final posts) when posts.isEmpty => MessageView(
            icon: Icons.inbox_outlined,
            message: t.no_posts_loaded,
          ),
          PostsLoaded(:final posts) => RefreshIndicator(
            onRefresh: () => context.read<PostsCubit>().load(),
            child: ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, index) => PostTile(post: posts[index]),
            ),
          ),
        },
      ),
    );
  }
}

class _LoadPrompt extends StatelessWidget {
  const _LoadPrompt({required this.onLoad});

  final VoidCallback onLoad;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MessageView(icon: Icons.article_outlined, message: t.no_posts_loaded),
          FilledButton.icon(
            onPressed: onLoad,
            icon: const Icon(Icons.download),
            label: Text(t.load_posts),
          ),
        ],
      ),
    );
  }
}
