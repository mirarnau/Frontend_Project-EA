import 'dart:convert';
import 'package:flutter_tutorial/config.dart';
import 'package:flutter_tutorial/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class PostService {
  var baseUrl = apiURL + "/api/posts";


  Future<List<Post>?> getAllPosts() async {
    var res = await http.get(Uri.parse(baseUrl),
      headers: {'authorization': LocalStorage('key').getItem('token')});
      
    if (res.statusCode == 200) {
      List<Post> listPosts = [];
      var decoded = jsonDecode(res.body);
      decoded.forEach((eachPost) => listPosts.add(Post.fromJSON(eachPost)));
      return listPosts;
    }
    return null;
  }

  Future<List<Post>?> getMyPosts (String ownerName) async {
    var res = await http.get(Uri.parse(baseUrl + '/' + ownerName),
      headers: {'authorization': LocalStorage('key').getItem('token')});
    if (res.statusCode == 200) {
      List <Post> listPosts = [];
      var decoded = jsonDecode(res.body);
      decoded.forEach((eachPost) => listPosts.add(Post.fromJSON(eachPost)));
      return listPosts;
    }
    return null;
  }


  Future<bool> addComment (Comment comment, String postId) async {
    var res = await http.post(Uri.parse(baseUrl + '/addComment/' + postId),
        headers: {'authorization': LocalStorage('key').getItem('token'), 'content-type': 'application/json'},
        body: json.encode(Comment.toJson(comment)));

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> updatePost (Post postUpdate) async {
    var res = await http.put(Uri.parse(baseUrl + '/' + postUpdate.id),
        headers: {'authorization': LocalStorage('key').getItem('token'), 'content-type': 'application/json'},
        body: json.encode(Post.toJson(postUpdate)));

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<Post?> addPost(Post post) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: {'authorization': LocalStorage('key').getItem('token'),'content-type': 'application/json'},
        body: json.encode(Post.toJson(post)));

    if (res.statusCode == 201) {
      Post newPost = Post.fromJSON(json.decode(res.body));
      return newPost;
    }
    return null;
  }

  Future<bool> likePost (Like like, String postId) async {
    var res = await http.post(Uri.parse(baseUrl + '/addLike/' + postId),
        headers: {'authorization': LocalStorage('key').getItem('token'), 'content-type': 'application/json'},
        body: json.encode(Like.toJson(like)));

    if (res.statusCode == 201) {
      return true;
    }
    return false; //Meaning now we have a dislike
  }

  Future<bool> deletePost (String postId) async {
    var res = await http.delete(Uri.parse(baseUrl + '/' + postId),
      headers: {'authorization': LocalStorage('key').getItem('token')});
      
    int statusCode = res.statusCode;
    if (statusCode == 200) return true;
    return false;
  }


}
