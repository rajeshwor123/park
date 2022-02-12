import 'package:flutter/material.dart';
import 'package:park/util/page_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageRoutes.loginRoute);
        },
          child : const Icon(Icons.account_box),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: const Center(child: Text("hello world")),
      drawer: const Drawer(),
    );
  }
}
