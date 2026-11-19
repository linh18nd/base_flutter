part of 'post_search_bloc.dart';

@freezed
sealed class PostSearchState with _$PostSearchState {
  /// Query is empty; nothing searched yet.
  const factory PostSearchState.idle() = PostSearchIdle;
  const factory PostSearchState.loading(String query) = PostSearchLoading;
  const factory PostSearchState.loaded({
    required String query,
    required List<Post> posts,
  }) = PostSearchLoaded;
  const factory PostSearchState.failure({
    required String query,
    required Failure failure,
  }) = PostSearchFailure;
}
