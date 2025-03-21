import '../../data/repositories/post_repository.dart';
import '../entities/post.dart';



class DeletePosts {
  final PostRepository repository;

  DeletePosts(this.repository);

  Future<void> call( postid) {
    return repository.deletePost(postid);
  }
}