import 'package:flutter/material.dart';
import 'package:park/model/page_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
import 'package:location/location.dart';

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

  Future<bool> getPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      session = sharedPreferences.getBool('session') ?? false;
      return session;
  }

  Future findLocation()async{
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
  currentLocation()async{
    var position= await findLocation();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    mapController.move(lat_lng.LatLng(latitude,longitude), 13.0);
  }

    @override
    void initState(){
      super.initState();
      currentLocation();
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            session = await getPrefs();
            if (session == true) {
              Navigator.pushNamed(context, PageRoutes.profileRoute);
            } else {
              Navigator.pushNamed(context, PageRoutes.loginRoute);
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
                urlTemplate: "https://api.mapbox.com/styles/v1/rajeshwor/cl0vznvsi00mr14qifgbuzg7h/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFqZXNod29yIiwiYSI6ImNsMHZ6Znl2MjA5N3Uzam5zMXdnN21oZDMifQ.ViceToG3TkxFoI4mjUs4Kw",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1IjoicmFqZXNod29yIiwiYSI6ImNsMHZ6Znl2MjA5N3Uzam5zMXdnN21oZDMifQ.ViceToG3TkxFoI4mjUs4Kw',
                  'id': 'mapbox.mapbox-streets-v8'
                }
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: lat_lng.LatLng(latitude, longitude),
                    builder: (ctx) => IconButton(
                      onPressed: () { },
                      icon: const Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45.0,
                    )
                ),
              ],
            ),
          ],
        ),
        drawer: const Drawer(),
      ),
    );
  }
}
