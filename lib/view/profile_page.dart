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

  String userName = '';
  String phone = '';
  String email = '';

  bool changeButton = false;
  bool changeButton1 = false;

  callLogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getBool('session') == true) {
      String? email = sharedPreferences.getString('email');
      String? password = sharedPreferences.getString('password');
      Profile profile = await Service.getProfile(email??"", password??"");

      setState(() {
        userName = profile.userName;
        phone = profile.phone;
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
    setState(() {
      changeButton1 = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    await Navigator.pushNamed(context, PageRoutes.chooseLocRoute);
    if(mounted){
      setState(() {
        changeButton1 = false;
      });
    }
  }

  @override
  initState(){
    super.initState();
    callLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Form(
        child: Column(
          children: [
            Text(userName),
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
      ) ,
      ),
    );
      //child: Text(userName),textStyle: const TextStyle(fontSize: 100),);
  }
}
