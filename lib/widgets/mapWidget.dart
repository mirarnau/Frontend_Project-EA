// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';

import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart'; 

class MapWidget extends StatefulWidget {
  final double longRestaurant;
  final double latRestaurant;
  const MapWidget({Key? key, required this.longRestaurant, required this.latRestaurant}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  Position? _position;

  late  double longPosition;
  late  double latPosition;

  late List <Marker> listMarkers = [];

  @override
  void initState() {
    //getCurrentLocation();
    listMarkers.add(Marker(point: LatLng(widget.longRestaurant, widget.latRestaurant), builder: (context)=> Icon(
                  Icons.location_on,
                  color: Colors.red,
                )));
                
  }

  addMarker(Marker marker) {
    print ('A');
      //listMarkers.add(marker);
      setState(() {
        listMarkers.add(marker);
      });
  }

/*
  getCurrentLocation () async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = position;
      Marker myPosMarker = Marker(point: LatLng(position.longitude, position.latitude), builder: (context)=> Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ));
      listMarkers.add(myPosMarker);
    });
    
  }
  */
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(widget.longRestaurant, widget.latRestaurant),
            zoom: 16.0,
            onTap: (tapPosition, latLong) => {
              longPosition = latLong.longitude,
              latPosition = latLong.latitude,
              
              addMarker(Marker(point: LatLng(longPosition, latPosition), builder: (context)=> Icon(
                  Icons.location_on,
                  color: Colors.red,)))
            
            }
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: listMarkers
            )
          ],
        )
      ],
    );
  }
}