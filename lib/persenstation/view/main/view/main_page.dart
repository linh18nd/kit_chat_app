import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_theme/theme_export.dart';
import 'package:kit_chat_app/persenstation/view/friend/views/friend_page.dart';
import 'package:kit_chat_app/persenstation/view/home/view/home_page.dart';
import 'package:kit_chat_app/persenstation/view/main/controllers/main_controller.dart';
import 'package:kit_chat_app/persenstation/view/main/view/widget/main_item.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bianca,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: AppColors.accentColor.withOpacity(0.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 8.sp,
          ),
          child: Row(
            children: List.generate(
              MainItem.values.length,
              (index) {
                return Expanded(
                  flex: 1,
                  child: Obx(
                    () => navBarItem(
                      context,
                      index,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget navBarItem(
    BuildContext context,
    int index,
  ) {
    final mainItem = MainItem.values.elementAt(index);

    return IconButton(
      splashRadius: 24.sp,
      onPressed: () async => await controller.onChangedNav(index),
      icon: Icon(
        mainItem.getIcon(),
        color: controller.rxCurrentNavIndex.value == index
            ? AppColors.accentColor
            : AppColors.greyChateau,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    final List<Widget> listScreenTab = [
      const HomePage(),
      const FriendPage(),
    ];
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.rxCurrentNavIndex.value,
          children: listScreenTab,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
