import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
