import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/friend/controllers/friend_controllers.dart';

class FriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendController>(() => FriendController());
  }
}
