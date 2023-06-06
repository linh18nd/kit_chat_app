import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/app_theme/theme_export.dart';
import 'package:kit_chat_app/persenstation/view/home/controllers/home_controller.dart';
import 'package:kit_chat_app/persenstation/view/home/view/widget/conversation_item.dart';
import 'package:kit_chat_app/persenstation/view/home/view/widget/home_appbar.dart';
import 'package:kit_chat_app/persenstation/widget/app_loading_widget.dart';
import 'package:kit_chat_app/route/app_route.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadedType.value == LoadedType.start
          ? const Scaffold(
              body: Center(
                child: AppLoadingWidget(),
              ),
            )
          : Scaffold(
              appBar: HomeAppBar(
                user: controller.user,
                onLogout: () {
                  controller.signOut();
                },
                onSearch: () {
                  controller.search(controller.searchBarController.text);
                },
              ),
              body: Column(
                children: [
                  _buildSearchBar(),
                  Expanded(
                    child: _buildConversations(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildConversations() {
    return Obx(
      () => controller.friends.isEmpty
          ? const Center(child: Text('Khong cos data'))
          : ListView.builder(
              itemCount: controller.friends.length,
              itemBuilder: (context, index) {
                final conversation = controller.conversations[index];
                return ConversationItem(
                  onTap: () {
                    Get.toNamed(AppPath.chat, arguments: {
                      'conversationId': conversation.conversationId,
                      'user': controller.user,
                      'friend': controller.friends[index],
                    });
                  },
                  user: controller.friends[index],
                  lastMessage: controller.conversations[index].lastMessage ??
                      "Cuộc trò chuyện mới",
                  lastMessageAt: controller.conversations[index].lastMessageAt,
                );
              },
            ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.21),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller.searchBarController,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm',
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
          ),
          border: InputBorder.none,
          prefixIcon: IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.textSecondary,
            ),
            onPressed: () {},
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.close,
              color: AppColors.textSecondary,
            ),
            onPressed: () {
              controller.searchBarController.clear();
            },
          ),
        ),
        onSubmitted: (value) {
          controller.search(value);
        },
        style: const TextStyle(color: AppColors.textColor),
      ),
    );
  }
}
