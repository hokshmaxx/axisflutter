import '../entities/post.dart';
import '../repositories/post_repository_interface.dart';

class GetPosts {
  final PostRepositoryInterface repository;
  GetPosts(this.repository);

  Future<List<Post>> call() async {
    return await repository.getPosts();
  }
}