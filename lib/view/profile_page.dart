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


  String userName = "";
  String? email = "";
  String phone = "";
  double? latitude ;
  double? longitude;
  String? bikePrice = "";
  String? carPrice = "";
  String? truckPrice = "";
  String? isAvailable = "";
  bool changeButton1 = false;
  String? errorComment = "";
  bool changeButton = false;


  callDb()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getBool('session') == true) {
      email = sharedPreferences.getString('email');
      String? password = sharedPreferences.getString('password');
      Profile profile = await Service.getProfile(email??"", password??"");

      setState(() {
        userName = profile.userName;
        email = profile.email;
        phone = profile.phone;
        bikePrice = profile.bikePrice;
        carPrice = profile.carPrice;
        truckPrice = profile.truckPrice;
        isAvailable = profile.isAvailable;
        latitude = profile.latitude;
        longitude = profile.longitude;
      });
    }
    else{moveToLogin(context);}
  }

  moveToLogin(BuildContext context)async{
    setState(() {
      changeButton = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('session', false);
    sharedPreferences.setString('email', '');
    sharedPreferences.setString('password', '');
    sharedPreferences.setString('latitude', '');
    sharedPreferences.setString('longitude', '');
    await Navigator.pushReplacementNamed(context, PageRoutes.loginRoute);
    if(mounted){
      setState(() {
        changeButton1 = false;
      });
    }

  }

  moveToChooseLoc(BuildContext context)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      changeButton1 = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    await Navigator.pushNamed(context, PageRoutes.chooseLocRoute);
    if(mounted){
      setState(() {
        latitude = sharedPreferences.getDouble("latitude");
        longitude = sharedPreferences.getDouble("longitude");
        changeButton1 = false;
      });
    }
  }

  String name = "";

  @override
  initState(){
    super.initState();
    callDb();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.person_rounded,size: 50,color: Colors.cyan),
                  const SizedBox(width: 15),
                  Text(userName??"", style: const TextStyle( fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Icon(Icons.call_rounded,size: 50,color: Colors.greenAccent),
                  const SizedBox(width: 15),
                  Text(phone??"", style: const TextStyle( fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Icon(Icons.directions_car_filled_rounded,size: 50,color: Colors.deepOrange),
                  const SizedBox(width: 15),
                  Text(carPrice??"", style: const TextStyle( fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Icon(Icons.delivery_dining_rounded,size: 50,color: Colors.indigo),
                  const SizedBox(width: 15),
                  Text(bikePrice??"", style: const TextStyle( fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Icon(Icons.directions_bus_rounded,size: 50,color: Colors.amber),
                  const SizedBox(width: 15),
                  Text(truckPrice??"", style: const TextStyle( fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Icon(Icons.check_circle_rounded,size: 45,color: Colors.black87),
                  const SizedBox(width: 15),
                  Text(isAvailable??"", style: const TextStyle( fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 100.0),
              Material(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(changeButton ? 20 : 10),
                child: InkWell(
                  onTap: () => moveToChooseLoc(context),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: changeButton1 ? 300 : 150,
                    height: changeButton1 ? 25 : 40,
                    alignment: Alignment.center,
                    child: const Text(
                      "choose Location",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),

              const SizedBox(height: 100,),
              Material(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(changeButton ? 20 : 10),
                child: InkWell(
                  onTap: () => moveToLogin(context),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: changeButton ? 300 : 100,
                    height: changeButton ? 25 : 40,
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
      ) ,
      ),
    );
      //child: Text(userName),textStyle: const TextStyle(fontSize: 100),);
  }
}
