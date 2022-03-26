import 'dart:convert';
import 'package:park/model/page_routes.dart';
import 'package:http/http.dart' as http;
import 'package:park/model/profile_data.dart';
import 'package:park/view/profile_page.dart';
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
      "password": password,
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
      "password": password,
    });
    var data = json.decode(response.body);
    Profile profile = Profile.fromJson(data[0]);
    return profile;
  }
}
