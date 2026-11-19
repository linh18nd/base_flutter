import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/usecases/get_posts.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_cubit.freezed.dart';
part 'posts_state.dart';

/// Cubit: the UI calls [load] directly, no event classes needed.
class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this._getPosts) : super(const PostsState.initial());

  final GetPosts _getPosts;

  Future<void> load() async {
    emit(const PostsState.loading());
    final result = await _getPosts();
    emit(switch (result) {
      Ok(:final value) => PostsState.loaded(value),
      Err(:final failure) => PostsState.failure(failure),
    });
  }
}
