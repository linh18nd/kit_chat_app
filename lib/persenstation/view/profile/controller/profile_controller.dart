import 'package:get/get.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';

class ProfileController extends GetxController {
  UserModel? user;

  @override
  void onInit() {
    super.onInit();
    user = Get.arguments as UserModel?;
  }
}
