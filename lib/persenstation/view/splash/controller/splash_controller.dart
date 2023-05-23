import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/route/app_route.dart';

class SplashController extends GetxController with AppController {
  final _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    loadedType.value = LoadedType.start;
    Future.delayed(const Duration(seconds: 2), () {
      loadedType.value = LoadedType.end;
    });
  }

  @override
  void onReady() {
    super.onReady();
    if (_auth.currentUser != null) {
      Get.offAllNamed(Path.main);
    } else {
      Get.offAllNamed(Path.login);
    }
  }
}
