import 'package:flutter/material.dart';
import 'package:park/screens/home_page.dart';
import 'package:park/screens/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park/util/page_routes.dart';


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
        PageRoutes.homeRoute : (context) => const HomePage(),
        PageRoutes.loginRoute: (context) => const LoginPage(),
      },
    );
  }
}
