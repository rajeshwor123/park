import 'package:flutter/material.dart';
import 'package:park/view/choose_location.dart';
import 'package:park/view/home_page.dart';
import 'package:park/view/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park/view/profile_page.dart';
import 'package:park/view/signup_page.dart';
import 'package:park/model/page_routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
      initialRoute: PageRoutes.homeRoute,
      routes: {
        PageRoutes.profileRoute : (context) => const ProfilePage(),
        PageRoutes.homeRoute : (context) => const HomePage(),
        PageRoutes.loginRoute: (context) => const LoginPage(),
        PageRoutes.signupRoute: (context) => const SignupPage(),
        PageRoutes.chooseLocRoute: (context) => const ChooseLocation()
      },
    );
  }
}
