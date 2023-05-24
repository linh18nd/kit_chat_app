import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/controllers/chat_view_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
