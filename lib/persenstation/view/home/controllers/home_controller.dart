import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/domain/models/conversations_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/usecases/authencation_usecase.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/route/app_route.dart';

class HomeController extends GetxController with AppController {
  final AuthencationUseCase _authencationUseCase = getIt<AuthencationUseCase>();
  final _auth = FirebaseAuth.instance;
  TextEditingController searchBarController = TextEditingController();
  UserModel? user;
  RxList<ConversationsModel> conversations = <ConversationsModel>[].obs;
  RxList<UserModel> friends = <UserModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  onReady() async {
    super.onReady();
    loadedType.value = LoadedType.start;
    user = await _authencationUseCase.getUser();
    await getConversations();
    await Future.delayed(const Duration(seconds: 1));
    loadedType.value = LoadedType.end;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signOut() async {
    await _auth.signOut();

    Get.offAllNamed(AppPath.login);
  }

  Future getConversations() async {
    conversations.clear();
    friends.clear();
    FirebaseFirestore.instance
        .collection('conversations')
        .where('participants', arrayContains: user?.userId)
        .orderBy('lastMessageAt')
        .limitToLast(20)
        .snapshots()
        .listen(
      (snapshot) async {
        catchEvents(snapshot);
      },
    );
  }

  void catchEvents(QuerySnapshot<Map<String, dynamic>> snapshot) async {
    for (var change in snapshot.docChanges) {
      log('change: ${change.doc.data()}');
      final data = change.doc.data() ?? {};
      final conversation = ConversationsModel.fromJson(data);
      final conversationId = change.doc.id;

      if (change.type == DocumentChangeType.added) {
        conversations.insert(0, conversation);
        await getFriends(conversation);
      } else if (change.type == DocumentChangeType.modified) {
        final index = conversations.indexWhere(
            (conversation) => conversation.conversationId == conversationId);
        if (index != -1) {
          final existingConversation = conversations[index];
          final friend = friends[index];

          conversations.removeAt(index);
          friends.removeAt(index);
          conversations.insert(
              0,
              existingConversation.copyWith(
                lastMessage: conversation.lastMessage,
                lastMessageAt: conversation.lastMessageAt,
              ));
          friends.insert(0, friend);
        }
      } else if (change.type == DocumentChangeType.removed) {
        final index = conversations.indexWhere(
            (conversation) => conversation.conversationId == conversationId);
        if (index != -1) {
          conversations.removeAt(index);
          friends.removeAt(index);
        }
      }
    }
  }

  Future getFriends(ConversationsModel conversationModel) async {
    final friendId = conversationModel.participants
        .firstWhere((element) => element != user?.userId);
    final friend = await FirebaseFirestore.instance
        .collection('users')
        .doc(friendId)
        .get();

    friends.insert(0, UserModel.fromJson(friend.data() ?? {}));
  }

  void search(String value) {
    Get.toNamed(
      AppPath.search,
      arguments: value,
    );
  }
}
