import 'package:flutter_tutorial/models/message.dart';

class Post {
  late final String id;
  late final String creator;
  late final String description;
  late final String postImageUrl;
  late final List<Comment> comments;
  

  Post(
      {required this.creator,
      required this.description,
      required this.postImageUrl});

  factory Post.fromJSON(dynamic json) {
    Post post = Post(
        creator: json['creator'],
        description: json['description'],
        postImageUrl: json['postImageUrl']);

    post.id = json['_id'];
    post.comments = json['comments'].cast<Comment>();
    return post;
  }

  static Map<String, dynamic> toJson(Post post) {
    return {
      'creator': post.creator,
      'description': post.description,
      'postImageUrl': post.postImageUrl,
    };
  }
}

class Comment {
  late final String creatorName;
  late final String message;

  static Map<String, dynamic> toJson(Comment comment) {
    return {
      'creatorName': comment.creatorName,
      'message': comment.message,
    };
  }
}