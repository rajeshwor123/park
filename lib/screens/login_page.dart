import 'package:flutter/material.dart';
import 'package:park/util/page_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if(_formKey.currentState?.validate() ?? false) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      await Navigator.pushNamed(context, PageRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
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
                      decoration: const InputDecoration(hintText: "Username"),
                      validator: (value){
                        if(value?.isEmpty ?? true){
                          return "Please Enter Username !";
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
                      obscureText: true,
                      decoration: const InputDecoration(hintText: "Password"),
                      validator: (value){
                        if(value?.isEmpty ?? true){
                          return "Please Enter Password !";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
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

              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, PageRoutes.homeRoute);
              //   },
              //   child: const Text(
              //     "Login",
              //     style: TextStyle(fontSize: 16),
              //   ),
              //   style: TextButton.styleFrom(
              //       shadowColor: Colors.cyan, minimumSize: const Size(100, 30)),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
