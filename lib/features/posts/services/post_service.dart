import '../domain/entities/post.dart';
import '../domain/repositories/post_repository_interface.dart';

class PostService {
  final PostRepositoryInterface postRepository;

  PostService(this.postRepository);

  Future<List<Post>> getAllPosts() => postRepository.getPosts();
  Future<Post> createPost(Post post) => postRepository.createPost(post);
  Future<Post> updatePost(int id, Post post) => postRepository.updatePost(id, post);
  Future<void> deletePost(int id) => postRepository.deletePost(id);
}
