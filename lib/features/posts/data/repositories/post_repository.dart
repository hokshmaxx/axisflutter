import '../../../../core/network/api_client.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository_interface.dart';
import '../models/post_model.dart';

class PostRepository implements PostRepositoryInterface {
  final ApiClient apiClient;

  PostRepository(this.apiClient);

  @override
  Future<List<Post>> getPosts() async {
    final response = await apiClient.getRequest('posts');
    return (response.data as List)
        .map((json) => PostModel.fromJson(json))
        .map<Post>((postModel) => Post(
      id: postModel.id,
      title: postModel.title,
      content: postModel.content,
    ))
        .toList();
  }

  @override
  Future<Post> createPost(Post post) async {
    final response = await apiClient.postRequest('posts', {
      'title': post.title,
      'content': post.content,
    });
    final postModel = PostModel.fromJson(response.data);
    return Post(
      id: postModel.id,
      title: postModel.title,
      content: postModel.content,
    );
  }

  @override
  Future<Post> updatePost(int id, Post post) async {
    final response = await apiClient.putRequest('posts/$id', {
      'title': post.title,
      'content': post.content,
    });
    final postModel = PostModel.fromJson(response.data);
    return Post(
      id: postModel.id,
      title: postModel.title,
      content: postModel.content,
    );
  }

  @override
  Future<void> deletePost(int id) async {
    await apiClient.deleteRequest('posts/$id');
  }
}
