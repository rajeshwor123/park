import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:park/model/page_routes.dart';
import 'package:http/http.dart' as http;
import 'package:park/model/profile_data.dart';
import 'package:park/view/profile_page.dart';
import 'package:park/model/create_markers.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Service {
  static Future<bool> signup(
      var email, var password, var username, var phone) async {
    var uri = Uri.parse(PageRoutes.signupUrl);
    var response = await http.post(uri, body: {
      "email": email.text,
      "password": password.text,
      "phone": phone.text,
      "username": username.text,
    });
    var data = json.decode(response.body);
    if (data) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(PageRoutes.loginUrl);
    var response = await http.post(uri, body: {
      "email": email,
      "userPassword": password,
    });
    var data = json.decode(response.body);
    if (data.length == 1) {
      sharedPreferences.setString('email', email);
      sharedPreferences.setString('password', password);
      sharedPreferences.setBool('session', true);
      return true;
    } else {
      return false;
    }
  }

  static Future<Profile> getProfile(String email, String password) async {
    var uri = Uri.parse(PageRoutes.loginUrl);
    var response = await http.post(uri, body: {
      "email": email,
      "userPassword": password,
    });
    var data = json.decode(response.body);
    Profile profile = Profile.fromJson(data[0]);
    return profile;
  }



  static Future<Profile> getProfileFromId(String id) async {
    var uri = Uri.parse(PageRoutes.getProfileFromId);
    var response = await http.post(uri, body: {
      "userId" : id,
    });
    var data = json.decode(response.body);
    Profile profile = Profile.fromJson(data[0]);
    return profile;
  }


  static Future<bool> update(Profile profile) async {
    var uri = Uri.parse(PageRoutes.updateUrl);
    var response = await http.post(uri, body: {
      "email": profile.email??"",
      "userPassword": profile.userPassword??"",
      "phone": profile.phone??"",
      "userName": profile.userName??"",
      "carPrice": profile.carPrice??"",
      "bikePrice": profile.bikePrice??"",
      "truckPrice": profile.truckPrice??"",
      "cyclePrice":profile.cyclePrice??"",
      "isAvailable":profile.isAvailable??"",
      "latitude":profile.latitude,
      "longitude":profile.longitude,
    });
    var data = json.decode(response.body);
    if (data) {
      return true;
    } else {
      return false;
    }
  }

  static Future<http.Response> markerList()async {
    var uri = Uri.parse(PageRoutes.getLatLng);
    var response = await http.post(uri);
    //List<Marker> markers = await CreateMarkers.createMarkerList(response);
    return response;
  }
}
