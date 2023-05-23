import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/home/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(child: Text('Home Page')),
          ElevatedButton(
              onPressed: () {
                final _auth = FirebaseAuth.instance;
                _auth.signOut();
                Get.offAllNamed('/login');
              },
              child: Text('Log out'))
        ],
      ),
    );
  }
}
