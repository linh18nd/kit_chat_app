import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/domain/models/message_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/usecases/chat_model_usecase.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';

class ChatController extends GetxController with AppController {
  final ChatModelUsecase _chatModelUsecase = getIt<ChatModelUsecase>();
  final RxList<Message> messages = RxList<Message>();
  final TextEditingController messageController = TextEditingController();
  UserModel? friend;
  String conversationId = '';
  String userId = '';
  @override
  void onInit() {
    super.onInit();
    conversationId = Get.arguments['conversationId'];
    userId = Get.arguments['userId'];
    friend = Get.arguments['friend'];
  }

  @override
  void onReady() {
    super.onReady();
    getMessages(conversationId);
  }

  void getMessages(String chatId) async {
    loadedType.value = LoadedType.start;
    messages.bindStream(_chatModelUsecase.getChatModels(chatId));
    loadedType.value = LoadedType.end;
  }

  void sendMessage() async {
    final message = Message(
      content: messageController.text,
      senderId: userId,
      timestamp: DateTime.now(),
    );
    await _chatModelUsecase.sendMessage(message, conversationId);
    messageController.clear();
  }

  bool isMe(Message message) {
    return message.senderId == userId;
  }
}
