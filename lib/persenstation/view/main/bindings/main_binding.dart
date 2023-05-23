import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}
