
class Post {
  late final String id;
  late final String creator;
  late final String profileImage;
  late final String description;
  late final String postImageUrl;
  late final List<Comment> comments;
  late final List<Like> likes;
  

  Post(
      {required this.creator,
      required this.profileImage,
      required this.description,
      required this.postImageUrl});

  factory Post.fromJSON(dynamic json) {
    Post post = Post(
        creator: json['creator'],
        profileImage: json['profileImage'],
        description: json['description'],
        postImageUrl: json['postImageUrl']);

    post.id = json['_id'];

    final commentsData = json['comments'] as List<dynamic>?;
    final commentsList = commentsData != null
      ? commentsData.map((commentData) => Comment.fromJSON(commentData)).toList() : <Comment>[];
    post.comments = commentsList;

    final likesData = json['likes'] as List<dynamic>?;
    final likesList = likesData != null
      ? likesData.map((likeData) => Like.fromJSON(likeData)).toList() : <Like>[];
    post.likes = likesList;


    return post;
  }

  static Map<String, dynamic> toJson(Post post) {
    return {
      'creator': post.creator,
      'description': post.description,
      'postImageUrl': post.postImageUrl,
      'likes': post.likes
    };
  }
}


class Comment {
  late final String creatorName;
  late final String message;

  Comment({
    required this.creatorName,
    required this.message
  });

  factory Comment.fromJSON(dynamic json) {
    Comment comment = Comment(
        creatorName: json['creatorName'],
        message: json['message']);
    return comment;
  }

  static Map<String, dynamic> toJson(Comment comment) {
    return {
      'creatorName': comment.creatorName,
      'message': comment.message,
    };
  }
}

class Like {
  late final String customerName;
  late final int number;

  Like({
    required this.customerName,
    required this.number
  });

  factory Like.fromJSON(dynamic json) {
    Like like = Like(
        customerName: json['customerName'],
        number: json['number']);
    return like;
  }

  static Map<String, dynamic> toJson(Like like) {
    return {
      'customerName': like.customerName,
      'number': like.number,
    };
  }
}