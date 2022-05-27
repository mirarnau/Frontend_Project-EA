// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';

import 'package:latlong2/latlong.dart'; 

class MapWidget extends StatelessWidget {

  final double longRestaurant;
  final double latRestaurant;

  MapWidget({
    required this.longRestaurant,
    required this.latRestaurant
  });
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(longRestaurant, latRestaurant),
            zoom: 13.0
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: [Marker(
                width: 100.0,
                height: 100.0,
                point: LatLng(longRestaurant, latRestaurant),
                builder: (context)=> Icon(
                  Icons.location_on,
                  color: Colors.red,
                )
              )]
            )
          ],
        )
      ],
    );
  }
}