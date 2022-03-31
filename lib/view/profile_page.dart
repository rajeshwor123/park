import 'dart:ui';

import 'package:park/model/service.dart';
import 'package:park/model/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:park/model/page_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String? password = "";
  String? userName = "";
  String? email = "";
  String? phone = "";
  double? latitude;
  double? longitude;
  String? bikePrice = "";
  String? carPrice = "";
  String? truckPrice = "";
  String? isAvailable = "";
  String? cyclePrice = "";
  bool makeSpot = false;
  bool changeLocationButton = false;
  String? errorComment = "";
  bool changeLogoutButton = false;
  bool changeSpotButton = false;
  bool changeRemoveButton = false;
  final _formKey = GlobalKey<FormState>();
  String? displayLat = "";
  String? displayLon = "";

  TextEditingController isAvailableController = TextEditingController();
  TextEditingController carPriceController = TextEditingController();
  TextEditingController truckPriceController = TextEditingController();
  TextEditingController bikePriceController = TextEditingController();
  TextEditingController cyclePriceController = TextEditingController();
  TextEditingController decisionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  callDb() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('session') == true) {
      email = sharedPreferences.getString('email');
      password = sharedPreferences.getString('password');
      Profile profile = await Service.getProfile(email ?? "", password ?? "");

      setState(() {
        userName = profile.userName;
        phone = profile.phone;
        bikePrice = profile.bikePrice;
        carPrice = profile.carPrice;
        truckPrice = profile.truckPrice;
        isAvailable = profile.isAvailable;
        latitude = double.tryParse(profile.latitude.toString()) != null ? double.parse(profile.latitude!) : null;
        longitude = double.tryParse(profile.longitude.toString()) != null ? double.parse(profile.longitude!) : null;
        cyclePrice = profile.cyclePrice;
        displayLat = latitude?.toStringAsFixed(1) ?? "";
        displayLon = longitude?.toStringAsFixed(1) ?? "";

        if (latitude != null && longitude != null) {
          makeSpot = true;
        } else {
          makeSpot = false;
        }

        isAvailableController.text = userName ?? "";
        carPriceController.text = carPrice ?? "";
        truckPriceController.text = truckPrice ?? "";
        cyclePriceController.text = cyclePrice ?? "";
        bikePriceController.text = bikePrice ?? "";
        phoneController.text = phone ?? "";
        userNameController.text = userName ?? "";
      });
    } else {
      moveToLogin(context);
    }
  }

  moveToLogin(BuildContext context) async {
    setState(() {
      changeLogoutButton = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('session', false);
    sharedPreferences.setString('email', '');
    sharedPreferences.setString('password', '');
    sharedPreferences.setString('latitude', '');
    sharedPreferences.setString('longitude', '');
    await Navigator.pushReplacementNamed(context, PageRoutes.loginRoute);
    if (mounted) {
      setState(() {
        changeLocationButton = false;
      });
    }
  }

  updateDetails(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    email = sharedPreferences.getString('email');
    password = sharedPreferences.getString('password');
     Profile profile = Profile.fromJson({
       "email": email,
       "userPassword": password ,
       "phone": phoneController.text,
       "userName": userNameController.text,
       "carPrice": carPriceController.text,
       "bikePrice": bikePriceController.text,
       "truckPrice": truckPriceController.text,
       "cyclePrice":cyclePriceController.text,
       "isAvailable":isAvailableController.text,
       "latitude":latitude.toString(),
       "longitude":longitude.toString(),
     });
     bool status = await Service.update(profile);
     if(status) {
       setState(() {
         changeSpotButton = true;
       });
       await Future.delayed(const Duration(seconds: 1));
     }

  }

  removeSpot(BuildContext context) async {}

  moveToChooseLoc(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      changeLocationButton = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    await Navigator.pushNamed(context, PageRoutes.chooseLocRoute);
    if (mounted) {
      setState(() {
        latitude = sharedPreferences.getDouble("latitude");
        longitude = sharedPreferences.getDouble("longitude");
        displayLat = latitude?.toStringAsFixed(1) ?? "";
        displayLon = longitude?.toStringAsFixed(1) ?? "";
        changeLocationButton = false;
      });
    }
  }

  String name = "";

  @override
  initState() {
    super.initState();
    callDb();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
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
                    controller: userNameController,
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
                          controller: phoneController,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.error_rounded,
                          size: 45, color: Colors.purple),
                      const SizedBox(width: 15),
                      Flexible(
                        child: TextFormField(
                          controller: isAvailableController,
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
                          controller: carPriceController,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.delivery_dining_rounded,
                          size: 50, color: Colors.indigo),
                      const SizedBox(width: 15),
                      Flexible(
                        child: TextFormField(
                          controller: bikePriceController,
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
                          controller: truckPriceController,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.directions_bike_rounded,
                          size: 45, color: Colors.black87),
                      const SizedBox(width: 15),
                      Flexible(
                        child: TextFormField(
                          controller: cyclePriceController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    children: [
                      Flexible(
                        child: Material(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(
                              changeLogoutButton ? 20 : 10),
                          child: InkWell(
                            onTap: () {
                              if (latitude != null && longitude != null) {
                                updateDetails(context);
                              } else {
                                setState(() {
                                  errorComment = "please choose a location";
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 200,
                              height: changeLocationButton ? 25 : 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        child: Material(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(
                              changeLogoutButton ? 20 : 10),
                          child: InkWell(
                            onTap: () => moveToChooseLoc(context),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 200,
                              height: changeSpotButton ? 25 : 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "Location",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        child: Material(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(
                              changeLogoutButton ? 20 : 10),
                          child: InkWell(
                            onTap: () => removeSpot(context),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 200,
                              height: changeLocationButton ? 25 : 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "Remove",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        errorComment ?? "",
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Spacer(),
                      Text(
                        "$displayLat , $displayLon",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Material(
                    color: Colors.cyan,
                    borderRadius:
                        BorderRadius.circular(changeLogoutButton ? 20 : 10),
                    child: InkWell(
                      onTap: () {
                        moveToLogin(context);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: changeLogoutButton ? 300 : 100,
                        height: changeLogoutButton ? 25 : 50,
                        alignment: Alignment.center,
                        child: const Text(
                          "logout",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    //child: Text(userName),textStyle: const TextStyle(fontSize: 100),);
  }
}
