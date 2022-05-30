// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OwnerCardRestaurant extends StatelessWidget {

  final String restaurantName;
  final String city;
  final String rating;
  final String address;
  final List<dynamic> imagesUrl;

  OwnerCardRestaurant({
      required this.restaurantName,
      required this.city,
      required this.rating,
      required this.address,
      required this.imagesUrl
    });

 @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 18, 18, 18).withOpacity(0.4),
                    offset: const Offset(
                      0.0,
                      10.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  ),
                ],
                
              ),
        width: MediaQuery.of(context).size.width,
        height: 240,
        child: Column(
          children: [
            Container  (
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black,
                
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.multiply,
                  ),
                  image: NetworkImage(imagesUrl[0]),     
                  fit: BoxFit.cover,
                ),
              ),
              
            ),
            Container(
              color: Colors.green,
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Stack(
                children: [
                  Align(
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              restaurantName,
                              style: const TextStyle(
                                fontSize: 19,
                                color: Colors.white
                              ),

                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top:10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                address,
                                style: const TextStyle(
                                  fontSize: 19,
                                  color: Colors.white
                                ),

                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),

                        )
                      ],
                    ),
                    alignment: Alignment.bottomLeft,
                  ),
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children:  [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                rating,
                                style: const TextStyle(
                                  color: Colors.white
                                ),),

                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                city,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    alignment: Alignment.bottomRight,
                  ),
                ],
              ),
            
            

            
          )
          ],
          
          
        ),
      ),
    );
  }
}

