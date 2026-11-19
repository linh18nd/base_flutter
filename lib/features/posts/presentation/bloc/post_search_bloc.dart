import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/usecases/search_posts.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'post_search_bloc.freezed.dart';
part 'post_search_event.dart';
part 'post_search_state.dart';

/// Waits for the user to stop typing, then switches to the latest query and
/// drops any search still in flight.
EventTransformer<E> debounceRestartable<E>(Duration duration) {
  return (events, mapper) =>
      restartable<E>().call(events.debounce(duration), mapper);
}

/// Bloc (not Cubit) because typing needs an event transformer: debounce so
/// we don't call the API on every keystroke, and `restartable` so a slow,
/// older search can never overwrite the results of a newer one.
class PostSearchBloc extends Bloc<PostSearchEvent, PostSearchState> {
  PostSearchBloc(
    this._searchPosts, {
    Duration debounce = const Duration(milliseconds: 350),
  }) : super(const PostSearchState.idle()) {
    on<PostSearchQueryChanged>(
      _onQueryChanged,
      transformer: debounceRestartable(debounce),
    );
  }

  final SearchPosts _searchPosts;

  Future<void> _onQueryChanged(
    PostSearchQueryChanged event,
    Emitter<PostSearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(const PostSearchState.idle());
      return;
    }

    emit(PostSearchState.loading(query));
    final result = await _searchPosts(query);
    emit(switch (result) {
      Ok(:final value) => PostSearchState.loaded(query: query, posts: value),
      Err(:final failure) => PostSearchState.failure(
        query: query,
        failure: failure,
      ),
    });
  }
}
