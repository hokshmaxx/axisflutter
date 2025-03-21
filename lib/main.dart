import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/network/api_client.dart';
import 'features/posts/data/repositories/post_repository.dart';
import 'features/posts/domain/use_cases/create_post.dart';
import 'features/posts/domain/use_cases/delete_post.dart';
import 'features/posts/domain/use_cases/get_posts.dart';
import 'features/posts/domain/use_cases/update_post.dart';
import 'features/posts/presentation/bloc/post_bloc.dart';
import 'features/posts/presentation/pages/PostsPage.dart';

void main() {
  setupDependencies();
runApp( MyApp());
}
final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<PostRepository>(() => PostRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<GetPosts>(() => GetPosts(getIt<PostRepository>()));
  getIt.registerLazySingleton<CreatePosts>(() => CreatePosts(getIt<PostRepository>()));
  getIt.registerLazySingleton<UpdatePosts>(() => UpdatePosts(getIt<PostRepository>()));
  getIt.registerLazySingleton<DeletePosts>(() => DeletePosts(getIt<PostRepository>()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(getIt<GetPosts>(),getIt<CreatePosts>(),getIt<UpdatePosts>(),getIt<DeletePosts>())..add(LoadPosts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostsPage(),
      ),
    );
  }
}
