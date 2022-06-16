import 'package:flutter/material.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';

class CardRestaurant extends StatelessWidget {

  final String restaurantName;
  final String city;
  final String rating;
  final List<dynamic> imagesUrl;
  final int occupation;
  final String address;


  CardRestaurant({
    required this.restaurantName,
    required this.city,
    required this.rating,
    required this.imagesUrl,
    required this.occupation,
    required this.address
  });
  
  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<double>( // <-- changed to "MirrorAnimation"
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      tween: Tween(begin: 110.0, end: 250.0),
      builder: (context, child, value) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 150,
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
                Colors.black.withOpacity(0.25),
                BlendMode.multiply,
              ),
              image: NetworkImage(imagesUrl[0]),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
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
                    textAlign: TextAlign.center,
                  ),
                ),
                alignment: Alignment.center,
              ),
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 45,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Icon(
                            Icons.people,
                            color: Color.fromARGB(255, value.toInt(), 0, 0),
                            size: 18,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            occupation.toString(),
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
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
                            city + ' - ' + address,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
        );
      },
    );
  }
}

