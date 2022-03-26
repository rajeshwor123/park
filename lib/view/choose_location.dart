import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  MapController mapController = MapController();
  List<Marker> allMarkers = [];
  double latitude = 27.7;
  double longitude = 85.3;

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

  @override
  void initState() {
    super.initState();
    currentLocation();
  }

  setShardPrefs()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble("latitude", latitude);
    sharedPreferences.setDouble("longitude", longitude);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            setShardPrefs();
              Navigator.pop(context);
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            onTap: ((tapPosition, point) {
              setState(() {
                latitude = point.latitude;
                longitude = point.longitude;
              });
            }),
            center: lat_lng.LatLng(latitude, longitude),
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
            MarkerLayerOptions(markers: [
              Marker(
                  width: 45.0,
                  height: 45.0,
                  point: lat_lng.LatLng(latitude, longitude),
                  builder: (ctx) => IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                      )),
            ]),
          ],
        ),
        drawer: const Drawer(),
      ),
    );
  }
}
