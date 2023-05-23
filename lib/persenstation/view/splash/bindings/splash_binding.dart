import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
