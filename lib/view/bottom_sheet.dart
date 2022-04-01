import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:park/model/page_routes.dart';
import 'package:park/model/profile_data.dart';
import 'package:park/model/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
import 'package:location/location.dart';


class BottomPopUp extends StatefulWidget {
  final Profile profile;
  const BottomPopUp({Key? key , required this.profile}) : super(key: key);

  @override
  _BottomPopUpState createState() => _BottomPopUpState();
}

class _BottomPopUpState extends State<BottomPopUp> {
  @override
  void initState(){
    super.initState;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Text("is it working?")
          ],
        )
    );
  }
}
