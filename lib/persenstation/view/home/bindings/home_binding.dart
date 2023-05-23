import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
