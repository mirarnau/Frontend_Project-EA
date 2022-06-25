// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PostWidget extends StatelessWidget {
  final String ownerName;
  final String profileImage;
  final String description;
  final String postImageUrl;

  PostWidget({
    required this.ownerName,
    required this.profileImage,
    required this.description,
    required this.postImageUrl,
  });

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
                  image: NetworkImage(profileImage)
                ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  ownerName,
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
              image: NetworkImage(postImageUrl)
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 5.0),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 30.0,
                  color: Colors.red),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.comment,
                  size: 30.0,

                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
          )
        ],
      ),
    );






    /*
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: 
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 161, 90, 85),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget> [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Row(
                        children: <Widget> [
                          Text(
                            ownerName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Image(
                        image: NetworkImage(postImageUrl)
                        ),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14
                        ),
                      ),
                    ],
                  ),

                )
              )
            
            ]
          ),
        ),
      ),

    );
    */


  }
}