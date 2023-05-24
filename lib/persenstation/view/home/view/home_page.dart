import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/route/app_route.dart';
import 'package:kit_chat_app/persenstation/view/home/controllers/home_controller.dart';
import 'package:kit_chat_app/persenstation/view/home/view/widget/home_appbar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadedType.value == LoadedType.start
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: HomeAppBar(
                  user: controller.user,
                  onLogout: () {
                    controller.signOut();
                  }),
              body: Obx(
                () => controller.friends.isEmpty
                    ? const Center(child: Text('Khong cos data'))
                    : ListView.builder(
                        itemCount: controller.conversations.length,
                        itemBuilder: (context, index) {
                          final conversation = controller.conversations[index];
                          return ListTile(
                              onTap: () {
                                Get.toNamed(Path.chat, arguments: {
                                  'conversationId': conversation.conversationId,
                                  'userId': controller.user?.userId,
                                  'friend': controller.friends[index],
                                });
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    controller.friends[index].avatarUrl),
                              ),
                              title: Text(controller.friends[index].username),
                              subtitle: Text(
                                conversation.lastMessage ??
                                    'Cuoc tro chuyen moi',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              trailing: Text(
                                  '${DateTime.now().difference(controller.conversations[index].lastMessageAt).inMinutes} phut truoc'));
                        },
                      ),
              ),
            ),
    );
  }
}
