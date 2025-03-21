part of 'post_bloc.dart';


abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final String title;
  final String content;

  CreatePost(this.title, this.content);
}

class UpdatePost extends PostEvent {
  final int id;
  final String title;
  final String content;

  UpdatePost(this.id, this.title, this.content);
}

class DeletePost extends PostEvent {
  final int id;

  DeletePost(this.id);
}
