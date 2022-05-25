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
    return Container  (
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black,
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
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.multiply,
          ),
          image: NetworkImage(imagesUrl[0]),     
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Align(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Color.fromARGB(255, 88, 88, 88)),
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
                  decoration: BoxDecoration(color: Color.fromARGB(255, 88, 88, 88)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
    );
  }
}

