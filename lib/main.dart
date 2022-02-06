import 'package:flutter/material.dart';
import 'package:park/screens/home_page.dart';
import 'package:park/screens/login_page.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          fontFamily: GoogleFonts.lato().fontFamily,

        ),
      initialRoute: "/login_page",
      routes: {
        "/home_page": (context) => const HomePage(),
        "/login_page": (context) => const LoginPage(),
      },
    );
  }
}
