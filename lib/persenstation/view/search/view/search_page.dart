import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/view/search/controllers/search_controller.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Search'),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: Obx(
        () => controller.loadedType.value == LoadedType.start
            ? const Center(child: CircularProgressIndicator())
            : controller.users.isEmpty
                ? const Center(
                    child: Text("Khong tìm thấy"),
                  )
                : ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final isFriend =
                          controller.checkFriend(controller.users[index]);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(controller.users[index].avatarUrl),
                        ),
                        title: Text(controller.users[index].username),
                        subtitle: Text(controller.users[index].email),
                        trailing: isFriend
                            ? IconButton(
                                onPressed: () {
                                  Get.back();
                                  controller
                                      .chatWithFriend(controller.users[index]);
                                },
                                icon: const Icon(Icons.message),
                              )
                            : IconButton(
                                onPressed: () {
                                  controller.addFriend(controller.users[index]);
                                  Get.back();
                                },
                                icon: const Icon(Icons.person_add),
                              ),
                      );
                    },
                  ),
      ),
    );
  }
}
