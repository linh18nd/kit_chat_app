import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/domain/repositories/authencation_repository.dart';
import 'package:kit_chat_app/domain/usecases/authencation_usecase.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/route/app_route.dart';

class LoginController extends GetxController with AppController {
  final AuthencationUseCase _authencationUseCase = getIt<AuthencationUseCase>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    loadedType.value = LoadedType.end;
  }

  void login(AuthencationType type) {
    loadedType.value = LoadedType.start;
    _authencationUseCase.logInWithSocial(type).then(
      (value) {
        if (_auth.currentUser != null) {
          Get.offAllNamed(AppPath.home);
        } else {
          Get.snackbar("Error", "Login failed");
        }
        Future.delayed(const Duration(seconds: 1), () {
          loadedType.value = LoadedType.end;
        });
        log("Login success");
      },
    );
  }

  void logout() {
    _authencationUseCase.logOut();
    Get.offAllNamed(AppPath.login);
  }
}
