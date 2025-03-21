import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';
import '../../domain/use_cases/create_post.dart';
import '../../domain/use_cases/delete_post.dart';
import '../../domain/use_cases/get_posts.dart';
import '../../domain/use_cases/update_post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
   final GetPosts getPosts;
   final CreatePosts  createPosts;
   final UpdatePosts updatePosts;
  final DeletePosts  deletePosts;


  PostBloc(this.getPosts, this.createPosts, this.updatePosts, this.deletePosts) : super(PostLoading()) {
    on<LoadPosts>((event, emit) async {
      try {
        final posts = await getPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
    on<CreatePost>((event, emit) async {
      try {

        await   createPosts!(Post(id: 0, title: event.title, content: event.content));
        emit(PostLoading());

        final posts = await getPosts();

        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
    on<DeletePost>((event, emit) async {
      try {
        await   deletePosts(event.id);

        emit(PostLoading());

        final posts = await getPosts();

        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
    on<UpdatePost>((event, emit) async {
      try {
        await   updatePosts(Post(id: event.id, title: event.title, content: event.content));
        emit(PostLoading());

        final posts = await getPosts();

        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
