import 'dart:developer';

import 'package:get/get.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/persenstation/service/agora.dart';
import 'package:vibration/vibration.dart';

class CallController extends GetxController {
  UserModel? friend;
  String token = '';
  UserModel? user;
  RxBool isListener = false.obs;
  @override
  void onInit() {
    super.onInit();
    AgoraService().setupVoiceSDKEngine();
    friend = Get.arguments['friend'];
    token = Get.arguments['token'];
    user = Get.arguments['user'];
    isListener.value = Get.arguments['isListener'] ?? false;
  }

  @override
  void onReady() async {
    super.onReady();
    if (!isListener.value) {}

    Vibration.vibrate(pattern: [500, 2000, 500, 2000, 500, 2000]);
  }

  @override
  void onClose() {
    AgoraService.disposeAgoraRtcEngine();
    super.onClose();
  }

  void endCall() {
    AgoraService.leaveChannel();
    Vibration.cancel();
    Get.back();
  }

  void joinChannel() {
    log('token: $token');
    AgoraService.join(token, user.hashCode);
  }
}
