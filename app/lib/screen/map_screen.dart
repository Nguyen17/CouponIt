import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../models/deals_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var currentLocation = <String, double>{};
  var _latitude;
  var _longitude;
  var location = new Location();

  @override
  void initState() {
    // TODO: implement initState
    getUserLocation();
  }

  getUserLocation() async {
    currentLocation = await location.getLocation();
    setState(() {
      currentLocation = currentLocation;
      _latitude = currentLocation["latitude"];
      _longitude = currentLocation["longitude"];
    });

    print("$currentLocation");
    print("${localDealsList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: FlutterMap(
                options: MapOptions(
                    center: LatLng(currentLocation["latitude"],
                        currentLocation["longitude"]),
                    minZoom: 10.0),

                /// CREATE MAP LAYERS
                layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(markers: markerList(localDealsList)
                  //        markers: [
                  // //          Marker(
                  // //   width: 10.0,
                  // //   height: 10.0,
                  // //   point: LatLng(currentLocation["latitude"],
                  // //     currentLocation["longitude"]),
                  // //     builder: (context) =>
                  // //     Container(
                  // //       child: Icon(Icons.place,
                  // //       color: Colors.blueAccent,
                  // //       ),
                  // //     )
                  // // ),

                  //        ]

                  ),
            ])));
  }

  List markerList(List mapAddress) {
    List<Marker> marker = [
      Marker(
          width: 10.0,
          height: 10.0,
          point:
              LatLng(currentLocation["latitude"], currentLocation["longitude"]),
          builder: (context) => Container(
                child: Icon(
                  Icons.place,
                  color: Colors.blueAccent,
                ),
              ))
    ];

    for (var i = 0; i < mapAddress.length; ++i) {
      var _mlatitude = mapAddress[i]['deal']['merchant']['latitude'];
      var _mlongitude = mapAddress[i]['deal']['merchant']['longitude'];
      marker.add(Marker(
          // width: 20.0,
          // height: 20.0,
          point: LatLng(_mlatitude, _mlongitude),
          builder: (context) => 
         Tooltip(
           message: mapAddress[i]['deal']['short_title'],
           child:   Container(
                child: IconButton(
                  onPressed:(){
                      _launchURL("https://www.google.com/maps/search/?api=1&query=$_mlatitude,$_mlongitude", context);
                  },
                  icon: Icon(Icons.place,
                  size: 21.0,),
                  color: Colors.pinkAccent,
                ),
              ),
         )
          
              
              ));
    }

    return marker;
  }

  _launchURL(urlLink, context) async {
  var url = urlLink;
  if (await canLaunch(url)) {
    await launch(url);
  } else {

    throw 'Could not launch $url';
  }
}
}