import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/view/friend/controllers/friend_controllers.dart';

class FriendPage extends GetView<FriendController> {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FriendPage'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.loadedType.value == LoadedType.start
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _buildFriendRequest(),
      ),
    );
  }

  Widget _buildFriendRequest() {
    return ListView.builder(
      itemCount: controller.friendsRequest.length,
      itemBuilder: (context, index) {
        final friend = controller.friendsRequest[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(friend.avatarUrl),
          ),
          title: Text(friend.username),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  // controller.acceptFriendRequest(friend.userId);
                },
                icon: const Icon(Icons.check),
              ),
              IconButton(
                onPressed: () {
                  // controller.declineFriendRequest(friend.userId);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        );
      },
    );
  }
}
