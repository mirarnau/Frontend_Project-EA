// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/post.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/services/postService.dart';
import 'package:flutter_tutorial/widgets/postWidget.dart';

import 'mainPage.dart';

class WallPage extends StatefulWidget {
  final Customer? customer;
  const WallPage({Key? key, required this.customer}) : super(key: key);

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
  PostService postService = PostService();
  List<Post>? listPosts = [];
  bool isLoading = true;

  bool _refreshed  = false;

  @override
  void initState() {
    super.initState();
    getAllPosts();
  }

  Future<void> getAllPosts() async {
    listPosts = await postService.getAllPosts();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listPosts!.isEmpty){
      return Scaffold(
        body: Text('No posts yet'),
      );
    }
    return Scaffold(
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount:  listPosts!.length,
          itemBuilder: (context, index){
            return PostWidget(
              idPost: listPosts![index].id,
              ownerName: listPosts![index].creator,
              profileImage: listPosts![index].profileImage,
              description: listPosts![index].description,
              postImageUrl: listPosts![index].postImageUrl,
              likes: listPosts![index].likes,
              comments: listPosts![index].comments,
              customer: widget.customer!,
            );
          }
        ),
      ),

      
    );
  }
}
