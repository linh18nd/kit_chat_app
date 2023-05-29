import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/usecases/authencation_usecase.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/view/home/controllers/home_controller.dart';

class FriendController extends GetxController with AppController {
  final RxList<UserModel> friendsRequest = <UserModel>[].obs;
  final RxList<UserModel> friends = <UserModel>[].obs;
  final AuthencationUseCase _authencationUseCase = getIt<AuthencationUseCase>();
  final _fireStore = FirebaseFirestore.instance;

  UserModel? user = Get.find<HomeController>().user;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    user = await _authencationUseCase.getUser();
    // getFriends();
    getFriends(user?.friends ?? []);
    // getFriendsRequest();
    getFriends(user?.friendRequest ?? [], isRequest: true);
  }

  void getFriends(List<String> friendsId, {bool isRequest = false}) {
    loadedType.value = LoadedType.start;
    if (friendsId.isEmpty) {
      loadedType.value = LoadedType.end;
      return;
    }
    _fireStore
        .collection('users')
        .where('userId', whereIn: friendsId)
        .get()
        .then((snapshot) {
      if (isRequest) {
        friendsRequest.value =
            snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      } else {
        friends.value =
            snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      }
    });
    loadedType.value = LoadedType.end;
  }
}
