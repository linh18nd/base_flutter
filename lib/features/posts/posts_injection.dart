import 'package:base_flutter/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:base_flutter/features/posts/data/repositories/post_repository_impl.dart';
import 'package:base_flutter/features/posts/domain/repositories/post_repository.dart';
import 'package:base_flutter/features/posts/domain/usecases/get_posts.dart';
import 'package:base_flutter/features/posts/domain/usecases/search_posts.dart';
import 'package:base_flutter/features/posts/presentation/bloc/post_search_bloc.dart';
import 'package:base_flutter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:get_it/get_it.dart';

void registerPostsFeature(GetIt getIt) {
  getIt
    // Data
    ..registerLazySingleton(() => PostRemoteDataSource(getIt()))
    ..registerLazySingleton<PostRepository>(() => PostRepositoryImpl(getIt()))
    // Domain
    ..registerFactory(() => GetPosts(getIt()))
    ..registerFactory(() => SearchPosts(getIt()))
    // Presentation (new instance per screen)
    ..registerFactory(() => PostsCubit(getIt()))
    ..registerFactory(() => PostSearchBloc(getIt()));
}
