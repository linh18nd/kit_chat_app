import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';

class MainController extends GetxController with AppController {
  RxInt rxCurrentNavIndex = 0.obs;

  Future<void> onChangedNav(int index) async {
    rxCurrentNavIndex.value = index;

    if (index == 0) {}
    if (index == 1) {}
  }

  @override
  void onInit() {
    super.onInit();
  }
}
