import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart'as http;
import 'package:latlong2/latlong.dart' as lat_lng;
import 'dart:convert';

class CreateMarkers{

  static Future<List<Marker>> createMarkerList(http.Response response)async{
    List<Marker> markers = [];
    var data = await json.decode(response.body);
    for(int i = 0 ; i<data[0].length;i++){
      markers.add( Marker(
          key: Key(data[i]['userId']),
          width: 80.0,
          height: 80.0,
          point: lat_lng.LatLng(double.parse(data[i]['latitude']),double.parse(data[i]['longitude'])),
          builder: (ctx) => IconButton(
            onPressed: () { },
            icon: const Icon(Icons.location_on),
            color: Colors.cyan,
            iconSize: 45.0,
          )
      ),);
    }
    return markers;
  }

}