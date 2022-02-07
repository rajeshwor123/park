import 'package:flutter/material.dart';
import 'package:park/util/page_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_image.png",
              fit: BoxFit.cover,
            ),
            const Text(
              "Hi There !",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Username"),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, PageRoutes.homeRoute);
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 16),
              ),
              style: TextButton.styleFrom(
                  shadowColor: Colors.cyan, minimumSize: const Size(100, 30)),
            )
          ],
        ),
      ),
    );
  }
}
