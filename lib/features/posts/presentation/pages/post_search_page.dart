import 'package:base_flutter/core/l10n/failure_message.dart';
import 'package:base_flutter/core/widgets/status_views.dart';
import 'package:base_flutter/features/posts/presentation/bloc/post_search_bloc.dart';
import 'package:base_flutter/features/posts/presentation/posts_keys.dart';
import 'package:base_flutter/features/posts/presentation/widgets/post_tile.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class PostSearchPage extends StatelessWidget {
  const PostSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          key: PostsKeys.searchField,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: t.search_hint,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
          ),
          onChanged: (query) =>
              context.read<PostSearchBloc>().add(PostSearchQueryChanged(query)),
        ),
      ),
      body: BlocBuilder<PostSearchBloc, PostSearchState>(
        builder: (context, state) => switch (state) {
          PostSearchIdle() => MessageView(
            icon: Icons.manage_search,
            message: t.type_to_search,
          ),
          PostSearchLoading() => const LoadingView(),
          PostSearchFailure(:final failure) => FailureView(
            message: failure.message(t),
          ),
          PostSearchLoaded(:final query, :final posts) when posts.isEmpty =>
            MessageView(
              icon: Icons.search_off,
              message: t.no_results(query: query),
            ),
          PostSearchLoaded(:final posts) => ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, index) => PostTile(
              key: PostsKeys.postTile(posts[index].id),
              post: posts[index],
            ),
          ),
        },
      ),
    );
  }
}
