import '../entities/post.dart';

abstract class PostRepositoryInterface {
  Future<List<Post>> getPosts();
  Future<Post> createPost(Post post);
  Future<Post> updatePost(int id, Post post);
  Future<void> deletePost(int id);
}