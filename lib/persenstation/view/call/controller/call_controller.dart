import 'dart:developer';

import 'package:get/get.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/persenstation/service/agora.dart';

class CallController extends GetxController {
  UserModel? friend;
  String token = '';
  int userId = 0;
  @override
  void onInit() {
    super.onInit();
    AgoraService().setupVoiceSDKEngine();
    friend = Get.arguments['friend'];
    token = Get.arguments['token'];
    userId = Get.arguments['userId'];
  }

  @override
  void onClose() {
    AgoraService.disposeAgoraRtcEngine();
    super.onClose();
  }

  void endCall() {
    AgoraService.leaveChannel();
    Get.back();
  }

  void joinChannel() {
    log('token: $token');
    AgoraService.join(token, userId);
  }
}
