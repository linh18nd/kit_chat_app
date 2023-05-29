import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
