import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/domain/models/conversations_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/usecases/authencation_usecase.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/route/app_route.dart';

class SearchPageController extends GetxController with AppController {
  RxList<UserModel> users = <UserModel>[].obs;
  final _fireStore = FirebaseFirestore.instance;
  String keyword = '';
  final AuthencationUseCase _authencationUseCase = getIt<AuthencationUseCase>();

  UserModel? user;
  @override
  void onInit() {
    super.onInit();
    keyword = Get.arguments as String;
  }

  @override
  void onReady() async {
    super.onReady();
    user = await _authencationUseCase.getUser();
    searchUser(keyword);
  }

  void onClose() {
    super.onClose();
  }

  void chatWithFriend(UserModel friend) async {
    final conversationId = await _fireStore
        .collection('conversations')
        .where('participants', whereIn: [
          [user?.userId, friend.userId],
          [friend.userId, user?.userId],
        ])
        .get()
        .then((value) => value.docs.first.id);

    Get.toNamed(
      AppPath.chat,
      arguments: {
        'conversationId': conversationId,
        'userId': user?.userId,
        'friend': friend,
      },
    );
  }

  void addFriend(UserModel friend) async {
    await _fireStore.collection('users').doc(friend.userId).update({
      'friends': FieldValue.arrayUnion([user?.userId])
    });
    await _fireStore.collection('users').doc(user?.userId).update({
      'friends': FieldValue.arrayUnion([friend.userId])
    });
    createConversation(friend);
  }

  void createConversation(UserModel friend) async {
    final conversationsModel = ConversationsModel(
      lastMessageAt: DateTime.now(),
      participants: [user?.userId, friend.userId],
    );

    try {
      _fireStore
          .collection('conversations')
          .doc(conversationsModel.conversationId)
        ..set(conversationsModel.toJson())
        ..collection('messages').doc().set({});
    } catch (error) {
      log('Lỗi khi thêm bạn: $error');
    }
  }

  void searchUser(String keyword) async {
    loadedType.value = LoadedType.start;
    if (keyword.isEmpty) {
      return;
    }

    final query = _fireStore
        .collection("users")
        .where("username", isGreaterThanOrEqualTo: keyword.toUpperCase())
        .limit(10)
        .orderBy("username", descending: true);

    final resultSnapshot = await query.get();

    final result = resultSnapshot.docs
        .map((e) => UserModel.fromJson(e.data()))
        .where((element) => element.userId != user?.userId)
        .toList();
    users.assignAll(result);
    loadedType.value = LoadedType.end;
  }

  bool checkFriend(UserModel friend) {
    if (user?.friends.contains(friend.userId) == true) {
      return true;
    }
    return false;
  }

  bool checkFriendRequest(UserModel user) {
    if (user.friendRequest.contains(user.userId) == true) {
      return true;
    }
    return false;
  }
}
