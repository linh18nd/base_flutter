import 'dart:async';

import 'package:base_flutter/app/router/routes.dart';
import 'package:base_flutter/core/pagination/paged_state.dart';
import 'package:base_flutter/core/widgets/paged_list_view.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:base_flutter/features/posts/presentation/widgets/post_tile.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<PostsCubit>().refresh());
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final cubit = context.read<PostsCubit>();
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
      body: BlocBuilder<PostsCubit, PagedState<Post>>(
        builder: (context, state) => PagedListView<Post>(
          state: state,
          onRefresh: cubit.refresh,
          onLoadMore: cubit.loadMore,
          emptyMessage: t.no_posts_loaded,
          itemBuilder: (_, post) => PostTile(post: post),
        ),
      ),
    );
  }
}
