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
import 'package:park/view/bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapController mapController = MapController();
  bool session = false;
  double latitude = 27.7;
  double longitude = 85.3;
  bool iconPressed = false;
  String? id;
  List<Marker> markerList = [];

  Future<bool> getPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    session = sharedPreferences.getBool('session') ?? false;
    return session;
  }

  Future findLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }

  currentLocation() async {
    var position = await findLocation();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    mapController.move(lat_lng.LatLng(latitude, longitude), 13.0);
  }

  Future<Profile> profileFromID(String id)async{
    Profile profile = await Service.getProfileFromId(id);
    return profile;
  }
  late Profile profile;
  callMarkerList() async {
    await currentLocation();
    var response = await Service.markerList();
    var data = await json.decode(response.body);
    for (int i = 0; i < data[0].length; i++) {
      markerList.add(Marker(
        width: 80.0,
        height: 80.0,
        point: lat_lng.LatLng(double.parse(data[i]['latitude']), double.parse(data[i]['longitude'])),
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.location_on),
          color: Colors.cyan,
          iconSize: 55.0,
          onPressed: ()async {
            var res = await profileFromID(data[i]['userId']);
            setState(() {
              profile = res;
            });
            showModalBottomSheet(context: ctx, builder: (builder){
              return BottomPopUp(profile: profile);
            });
          },
        ),
      ));
    }
    setState(() {
      markerList.add(Marker(
          width: 80.0,
          height: 80.0,
          point: lat_lng.LatLng(latitude, longitude),
          builder: (ctx) => IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                color: Colors.red,
                iconSize: 45.0,
              )));
    });
  }

  @override
  void initState() {
    super.initState();
    callMarkerList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            session = await getPrefs();
            if (session == true) {
              Navigator.pushNamed(context, PageRoutes.profileRoute)
                  .then((value) async => setState(() {
                        callMarkerList();
                      }));
            } else {
              Navigator.pushNamed(context, PageRoutes.loginRoute)
                  .then((value) async => setState(() {
                        callMarkerList();
                      }));
            }
            setState(() {});
          },
          child: const Icon(Icons.account_box),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: lat_lng.LatLng(latitude, longitude),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/rajeshwor/cl0vznvsi00mr14qifgbuzg7h/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFqZXNod29yIiwiYSI6ImNsMHZ6Znl2MjA5N3Uzam5zMXdnN21oZDMifQ.ViceToG3TkxFoI4mjUs4Kw",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoicmFqZXNod29yIiwiYSI6ImNsMHZ6Znl2MjA5N3Uzam5zMXdnN21oZDMifQ.ViceToG3TkxFoI4mjUs4Kw',
                  'id': 'mapbox.mapbox-streets-v8'
                }),
            MarkerLayerOptions(
              markers: markerList,
            ),
          ],
        ),
        drawer: const Drawer(),
      ),
    );
  }
}
