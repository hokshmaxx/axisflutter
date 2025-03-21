import '../../data/repositories/post_repository.dart';
import '../entities/post.dart';

class UpdatePosts {
  final PostRepository repository;

  UpdatePosts(this.repository);

  Future<void> call(Post post) {
    return repository.updatePost(post.id,post);
  }
}