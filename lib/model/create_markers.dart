import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart' as lat_lng;
import 'dart:convert';
import 'package:park/model/service.dart';
import 'package:park/model/profile_data.dart';

class CreateMarkers {

  static String? id;
  static String? name;

  static profileFromId(id) async {
    Profile profile = await Service.getProfileFromId(id);
    print(name);
  }

  static Column bottomSheetDesign(id) {
    profileFromId(id);
    return Column(
      children: [
        Text("$name",textAlign: TextAlign.center,),
      ],
    );
  }

  static Future<List<Marker>> createMarkerList(http.Response response) async {
    List<Marker> markers = [];
    var data = await json.decode(response.body);
    for (int i = 0; i < data[0].length; i++) {
      markers.add(Marker(
        key: Key(data[i]['userId']),
        width: 80.0,
        height: 80.0,
        point: lat_lng.LatLng(double.parse(data[i]['latitude']),
            double.parse(data[i]['longitude'])),
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.location_on),
          color: Colors.cyan,
          iconSize: 55.0,
          onPressed: () {
            showModalBottomSheet(context: ctx, builder: (builder){
              return
                Container(
                child: bottomSheetDesign(data[i]['userId']),
              );
            });
          },
        ),
      ));
    }
    return markers;
  }
}
