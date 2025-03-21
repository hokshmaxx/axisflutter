import '../../data/repositories/post_repository.dart';
import '../entities/post.dart';

class CreatePosts {
  final PostRepository repository;

  CreatePosts(this.repository);

  Future<void> call(Post post) {
    return repository.createPost(post);
  }
}