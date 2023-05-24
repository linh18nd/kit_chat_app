import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/domain/models/conversations_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/usecases/authencation_usecase.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/route/app_route.dart';

class HomeController extends GetxController with AppController {
  final AuthencationUseCase _authencationUseCase = getIt<AuthencationUseCase>();
  final _auth = FirebaseAuth.instance;
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
    getConversations();
    loadedType.value = LoadedType.end;
  }

  void signOut() async {
    await _auth.signOut();

    Get.offAllNamed(Path.login);
  }

  Future getConversations() async {
    loadedType.value = LoadedType.start;
    FirebaseFirestore.instance
        .collection('conversations')
        .where('participants', arrayContains: user?.userId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        conversations.clear();

        for (var element in snapshot.docs) {
          final data = element.data();
          conversations.add(ConversationsModel.fromJson(data));
        }
        getFriends();
      },
    );

    loadedType.value = LoadedType.end;
  }

  Future getFriends() async {
    loadedType.value = LoadedType.start;
    friends.clear();
    for (var conversation in conversations) {
      final friendId = conversation.participants
          .firstWhere((element) => element != user?.userId);
      final friend = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .get();
      friends.add(UserModel.fromJson(friend.data()!));
    }
    loadedType.value = LoadedType.end;
  }
}
