import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/domain/models/conversations_model.dart';
import 'package:kit_chat_app/domain/models/participants_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/view/home/controllers/home_controller.dart';

class SearchPageController extends GetxController with AppController {
  RxList<UserModel> users = <UserModel>[].obs;
  final appController = Get.find<HomeController>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    getUsers();
  }

  void getUsers() {
    loadedType.value = LoadedType.start;
    FirebaseFirestore.instance.collection('users').get().then((snapshot) {
      log(snapshot.docs.toString());
      users.value =
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
    });
    loadedType.value = LoadedType.end;
  }

  void addFriend(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.userId)
        .update({
      'friends': FieldValue.arrayUnion([appController.user?.userId])
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(appController.user?.userId)
        .update({
      'friends': FieldValue.arrayUnion([user.userId])
    });
    createConversation(user);
  }

  void createConversation(UserModel user) async {
    final ConversationsModel conversationsModel = ConversationsModel(
      participants: [user.userId, appController.user?.userId],
      lastMessageAt: DateTime.now(),
    );
    try {
      await FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationsModel.conversationId)
          .set(conversationsModel.toJson());
      createMessage(conversationsModel.conversationId);
    } catch (error) {
      log('Lỗi khi thêm bạn: $error');
    }
  }

  void createMessage(String conversationId) async {
    try {
      final ChatModel chatModel = ChatModel(messages: []);
      await FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .doc()
          .set(chatModel.toJson());
    } catch (error) {
      log('Lỗi khi thêm bạn: $error');
    }
  }
}
