import 'dart:convert';
import 'package:park/model/page_routes.dart';
import 'package:http/http.dart' as http;
class Service{

      static Future<bool> signup(var email, var password, var username, var phone) async{
        var uri = Uri.parse(PageRoutes.signupUrl);
        var response = await http.post(uri,body:{
          "email" : email.text,
          "password" : password.text,
          "phone" : phone.text,
          "username" : username.text,
        });
        var data = json.decode(response.body);
        if(data){
          return true;
        }
        else{
          return false;
        }
      }

      static Future<bool> login(var email , var password) async{
      var uri = Uri.parse(PageRoutes.loginUrl);
      var response = await http.post(uri,body:{
        "email" : email.text,
        "password" : password.text,
      });
      var data = json.decode(response.body);
      if(data.length == 1){
        return true;
      }
      else{
        return false;
      }
  }
}