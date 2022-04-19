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


class PopUpDetails extends StatefulWidget {
  final Profile profile;
  const PopUpDetails({Key? key , required this.profile}) : super(key: key);

  @override
  _PopUpDetailsState createState() => _PopUpDetailsState();
}

class _PopUpDetailsState extends State<PopUpDetails> {
  @override
  void initState(){
    super.initState;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          Container(
              height: 80.0,
              width: 80.0,
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/profileEg.png",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(
                    width: 2.0,
                    style: BorderStyle.solid,
                    color: const Color.fromARGB(255, 0, 0, 0)),
              )),
          const SizedBox(width: 30),
          TextFormField(
            controller: TextEditingController(text: widget.profile.userName),
            enabled: false,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          Row(
            children: [
              const Icon(Icons.call_rounded,
                  size: 50, color: Colors.greenAccent),
              const SizedBox(width: 15),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: TextEditingController(text: widget.profile.phone),
                ),
              ),
              const Spacer(),
              const Icon(Icons.error_rounded,
                  size: 45, color: Colors.purple),
              const SizedBox(width: 15),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: TextEditingController(text: widget.profile.isAvailable),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const Icon(Icons.directions_car_filled_rounded,
                  size: 50, color: Colors.deepOrange),
              const SizedBox(width: 15),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: TextEditingController(text: widget.profile.carPrice),
                ),
              ),
              const Spacer(),
              const Icon(Icons.delivery_dining_rounded,
                  size: 50, color: Colors.indigo),
              const SizedBox(width: 15),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: TextEditingController(text: widget.profile.bikePrice),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const Icon(Icons.directions_bus_rounded,
                  size: 50, color: Colors.amber),
              const SizedBox(width: 15),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: TextEditingController(text: widget.profile.truckPrice),
                ),
              ),
              const Spacer(),
              const Icon(Icons.directions_bike_rounded,
                  size: 45, color: Colors.black87),
              const SizedBox(width: 15),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: TextEditingController(text: widget.profile.cyclePrice),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}