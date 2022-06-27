// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/post.dart';
import 'package:flutter_tutorial/pages/commentsPage.dart';
import 'package:flutter_tutorial/services/postService.dart';

class PostWidget extends StatefulWidget {
  final String idPost;
  final String ownerName;
  final String profileImage;
  final String description;
  final String postImageUrl;
  final List<Like> likes;
  final List<Comment> comments;
  final customer;
  final String role;

  const PostWidget({Key? key, required this.idPost, required this.ownerName, required this.profileImage,
    required this.description, required this.postImageUrl, required this.likes, required this.comments, required this.customer, required this.role}) : super(key: key);

   @override
  State<PostWidget> createState() => _PostWidgetState();
}

  class _PostWidgetState extends State<PostWidget> {
    PostService postService = PostService();

    late int _currentLikes = widget.likes.length;

    bool _isLiked = false;

    @override
    void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Image(
                  width: 30,
                  height: 30,
                  image: NetworkImage(widget.profileImage)
                ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.ownerName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: Image(
              image: NetworkImage(widget.postImageUrl)
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 5.0),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(
                    _isLiked
                    ? Icons.favorite
                    : Icons.favorite_border,
                    size: 30.0,
                    color: Colors.red),
                    onTap: () async {
                      if (widget.role == "customer"){
                        Like newLike = Like(customerName: widget.customer.customerName, number: widget.likes.length);
                        bool like = await postService.likePost(newLike, widget.idPost);
                        if (like == true){
                          setState(() {
                            _currentLikes = _currentLikes + 1;
                            _isLiked = true;
                          });
                        }
                        if (like == false){
                          setState(() {
                            _currentLikes = _currentLikes - 1;
                            _isLiked = false;
                          });
                        }
                      }
                      if (widget.role == "owner"){
                        Like newLike = Like(customerName: widget.customer.ownerName, number: widget.likes.length);
                        bool like = await postService.likePost(newLike, widget.idPost);
                        if (like == true){
                          setState(() {
                            _currentLikes = _currentLikes + 1;
                            _isLiked = true;
                          });
                        }
                        if (like == false){
                          setState(() {
                            _currentLikes = _currentLikes - 1;
                            _isLiked = false;
                          });
                        }
                      }
                    },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 15.0, 0.0),
                  child: Text(
                    _currentLikes.toString()
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.comment,
                    size: 30.0,
                  ),
                  onTap: (){
                    var route =
                      MaterialPageRoute(builder: (BuildContext context) => CommentsPage(customer: widget.customer, idPost: widget.idPost, comments: widget.comments, description: widget.description,role: widget.role,));
                      Navigator.of(context).push(route);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  child: Text(
                    widget.comments.length.toString(),
                  ),
                ),
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                  widget.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                )
              ],
            ),
          ),
          Divider(
                color: Color.fromARGB(255, 160, 160, 160),
              ),
        ],
      ),
    );
  }


  }
