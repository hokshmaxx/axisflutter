part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}
