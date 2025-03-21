import 'package:equatable/equatable.dart';

import '../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({required int id, required String title, required String content})
      : super(id: id, title: title, content: content);

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'],
    title: json['title'],
    content: json['content'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
  };
}