import 'dart:convert';
import 'package:park/model/page_routes.dart';
import 'package:http/http.dart' as http;
class Service{
      static Future login(var email , var password) async{
      var uri = Uri.parse(PageRoutes.url);
      var response = await http.post(uri,body:{
        "email" : email.text,
        "password" : password.text,
      });
      var user = json.decode(response.body);
      if(user.length == 1){
        print("loginnnnnnnnnnnnnnnnn");
      }
      else{
        print("not loginnnnnnnnnnnnnnnnn");
      }
  }
}