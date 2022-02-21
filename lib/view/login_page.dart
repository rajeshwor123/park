import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park/model/page_routes.dart';
import 'package:http/http.dart' as http;
import 'package:park/model/service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;
  String errorComment = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  moveToSignup(BuildContext context) {
    Navigator.pushReplacementNamed(context, PageRoutes.signupRoute);
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      bool status = await Service.login(email, password);
      if (status) {
        setState(() {
          errorComment = "";
          changeButton = true;
        });
        Service.login(email, password);
        await Future.delayed(const Duration(seconds: 1));
        await Navigator.pushReplacementNamed(context, PageRoutes.homeRoute);
        setState(() {
          changeButton = false;
        });
      } else {
        setState(() {
          errorComment = "Try again with correct data";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/login_image.png",
                fit: BoxFit.cover,
              ),
              Text(
                "Hi There ! $name",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(hintText: "email"),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter email !";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: "Password"),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter Password !";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              Text(errorComment, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 30.0),
              Material(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(changeButton ? 20 : 10),
                child: InkWell(
                  onTap: () => moveToHome(context),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: changeButton ? 300 : 100,
                    height: changeButton ? 25 : 40,
                    alignment: Alignment.center,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              InkWell(
                onTap: () => moveToSignup(context),
                child: const Text(
                  "Don't have an account ? Click to signup",
                  style: TextStyle(color: Colors.cyan),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
