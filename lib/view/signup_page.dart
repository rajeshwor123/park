import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park/model/page_routes.dart';
import 'package:park/model/service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String name = "";
  String errorComment = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController username = TextEditingController();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      bool status = await Service.signup(email,password,username,phone);
      if(status) {
        setState(() {
          errorComment = "";
          changeButton = true;
        });
        await Future.delayed(const Duration(seconds: 1));
        await Navigator.pushNamed(context, PageRoutes.homeRoute);
        setState(() {
          changeButton = false;
        });
      }
      else{
        setState(() {
          errorComment = "could not signup for given email";
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
                "assets/images/signup_image.png",
                fit: BoxFit.cover,
              ),
              Text(
                "Get Started ! $name",
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
                      controller : email,
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
                      controller: username,
                      decoration: const InputDecoration(hintText: "username"),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter username !";
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
                      controller: phone,
                      decoration: const InputDecoration(hintText: "Mobile number"),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter Mobile number !";
                        }
                        return null;
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
              Text(errorComment , style: const TextStyle(color: Colors.red),),
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
                      "Signup",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
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
