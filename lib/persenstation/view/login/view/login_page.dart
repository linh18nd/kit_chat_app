import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/domain/repositories/authencation_repository.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/view/login/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Obx(
        () => controller.loadedType.value == LoadedType.start
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.login(AuthencationType.google);
                    },
                    child: const Text('Login with Google'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.logout();
                    },
                    child: Text('Log out'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final _auth = FirebaseAuth.instance;
                      // show thong tin user
                      print(_auth.currentUser);
                    },
                    child: Text('Login with Facebook'),
                  ),
                ],
              ),
      ),
    ));
  }
}
