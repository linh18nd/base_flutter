part of 'post_search_bloc.dart';

sealed class PostSearchEvent {
  const PostSearchEvent();
}

final class PostSearchQueryChanged extends PostSearchEvent {
  const PostSearchQueryChanged(this.query);

  final String query;
}
