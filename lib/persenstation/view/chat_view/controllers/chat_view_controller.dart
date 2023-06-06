import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/domain/models/message_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/usecases/chat_model_usecase.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/view/widgets/image_preview_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ChatController extends GetxController with AppController {
  final ChatModelUsecase _chatModelUsecase = getIt<ChatModelUsecase>();
  final RxList<Message> messages = RxList<Message>();
  final TextEditingController messageController = TextEditingController();
  final Rx<LoadedType> loadedImage = LoadedType.end.obs;

  UserModel? friend;
  String conversationId = '';
  UserModel? user;
  @override
  void onInit() {
    super.onInit();
    conversationId = Get.arguments['conversationId'];
    user = Get.arguments['user'];
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

  void sendTextMessage() async {
    final content = messageController.text.trim();
    if (content.isEmpty) return;

    final message = Message(
      content: content,
      senderId: user?.userId ?? '',
      timestamp: DateTime.now(),
    );
    messageController.clear();
    await _chatModelUsecase.sendMessage(
        message, conversationId, friend?.messagingToken ?? '', user!);
  }

  void sendImageMessage(String imageUrls) async {
    final message = Message(
      content: jsonEncode(imageUrls),
      senderId: user?.userId ?? '',
      timestamp: DateTime.now(),
      type: MessageType.image,
    );
    await _chatModelUsecase.sendMessage(
        message, conversationId, friend?.messagingToken ?? '', user!);
  }

  bool isMe(Message message) {
    return message.senderId == user?.userId;
  }

  Future<void> openImagePicker(context) async {
    List<AssetEntity>? assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        sortPathsByModifiedDate: true,
        requestType: RequestType.image,
        maxAssets: 10,
      ),
    );
    final List<String> imageUrls = [];
    loadedImage.value = LoadedType.start;
    if (assets != null) {
      for (AssetEntity asset in assets) {
        final File? file = await asset.file;
        final String imageUrl = await uploadImageToFirebaseStorage(file!);
        imageUrls.add(imageUrl);
      }
    }
    if (imageUrls.isEmpty) {
      return;
    }
    loadedImage.value = LoadedType.end;
    sendImageMessage(imageUrls.join(', '));
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void openGallery() async {}

  void openImage(String url) {
    Get.to(() => ImagePreviewPage(imageUrl: url));
  }
}
