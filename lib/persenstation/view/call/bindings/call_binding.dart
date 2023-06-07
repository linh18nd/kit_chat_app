import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/call/controller/call_controller.dart';

class CallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallController>(() => CallController());
  }
}
