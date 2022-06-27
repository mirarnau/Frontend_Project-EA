// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/post.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/ownerMainPage.dart';
import 'package:flutter_tutorial/services/postService.dart';

class CommentsPage extends StatefulWidget {
  final List<Comment> comments;
  final String idPost;
  final String description;
  final customer;
  final role;
  const CommentsPage({Key? key, required this.idPost, required this.description, required this.comments, required this.customer, required this.role}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  
  final messageController = TextEditingController();
  PostService postService = PostService();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    if (widget.comments.isEmpty){
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Comments'),
        ),
        body: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    ),
                  ),
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 160, 160, 160),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                child: Text(
                  'There are no comments yet, be the first!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                  ),
                ),
              ),
              Expanded(
                child:
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                    child: ListView.builder(
                      itemCount: widget.comments.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                          child: Row(
                            children: [
                              Text(
                                widget.comments[index].creatorName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 174, 81, 74),
                                  fontSize: 15.0
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                widget.comments[index].message,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    ),
                  )
              ),
              Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: const Color.fromARGB(255, 43, 43, 43),
                child: Row(
                  children: <Widget>[
                    
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        style: TextStyle(
                          color: Color.fromARGB(255, 184, 184, 184)
                        ),
                        decoration: InputDecoration(
                          hintText: "Add a comment...",
                          hintStyle: TextStyle(color: Color.fromARGB(255, 184, 184, 184)),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: () async {
                        Comment newComment = Comment(creatorName: widget.customer.customerName, message: messageController.text );
                        await postService.addComment(newComment, widget.idPost);
                        widget.comments.add(newComment);
                        setState(() {});
                      },
                      child: Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: Color.fromARGB(255, 213, 94, 85),
                      elevation: 0,
                    ),
                  ],
                  
                ),
              ),
            ),
          ],
          )
      );
    }
    else{
      return Scaffold(
        appBar: AppBar(
          leading:  IconButton(
          icon:  Icon(Icons.arrow_back),
          onPressed: (){
            if (widget.role == "customer"){
              var route =
                MaterialPageRoute(builder: (BuildContext context) => MainPage(customer: widget.customer, selectedIndex: 2, transferRestaurantTags: [], chatPage: "Received"));
                Navigator.of(context).push(route);
            }
            if (widget.role == "owner"){
              var route =
                MaterialPageRoute(builder: (BuildContext context) => OwnerMainPage(owner: widget.customer, selectedIndex: 3, transferRestaurantTags: [], chatPage: "Received"));
                Navigator.of(context).push(route);
            }
            
          }
            
          ),
          centerTitle: true,
          title: Text('Comments'),
        ),
        body:
          Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    ),
                  ),
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 160, 160, 160),
              ),
              Expanded(
                child:
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                    child: ListView.builder(
                      itemCount: widget.comments.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                          child: Row(
                            children: [
                              Text(
                                widget.comments[index].creatorName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 174, 81, 74),
                                  fontSize: 15.0
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                widget.comments[index].message,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    ),
                  )
              ),
              Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: const Color.fromARGB(255, 43, 43, 43),
                child: Row(
                  children: <Widget>[
                    
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        style: TextStyle(
                          color: Color.fromARGB(255, 184, 184, 184)
                        ),
                        decoration: InputDecoration(
                          hintText: "Add a comment...",
                          hintStyle: TextStyle(color: Color.fromARGB(255, 184, 184, 184)),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: () async {
                        if (widget.role == "customer"){
                          Comment newComment = Comment(creatorName: widget.customer.customerName, message: messageController.text );
                          await postService.addComment(newComment, widget.idPost);
                          widget.comments.add(newComment);
                          setState(() {});
                        }
                        if (widget.role == "owner"){
                          Comment newComment = Comment(creatorName: widget.customer.ownerName, message: messageController.text );
                          await postService.addComment(newComment, widget.idPost);
                          widget.comments.add(newComment);
                          setState(() {});
                        } 
                      
                      },
                      child: Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: Color.fromARGB(255, 213, 94, 85),
                      elevation: 0,
                    ),
                  ],
                  
                ),
              ),
            ),
          ],
          )
      );
    }
}
}
