import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/persenstation/app_theme/color_theme.dart';
import 'package:kit_chat_app/persenstation/route/app_route.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.user, this.onLogout})
      : super(key: key);
  final UserModel? user;
  final VoidCallback? onLogout;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 56.h,
      elevation: 0,
      title: Text(
        user?.username ?? '',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: CircleAvatar(
        radius: 20.r,
        backgroundImage: NetworkImage(user?.avatarUrl ?? ''),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed(Path.search);
          },
          icon: const Icon(Icons.search),
          iconSize: 24.sp,
        ),
        IconButton(
          onPressed: onLogout,
          icon: Icon(
            Icons.logout,
            color: AppColors.background,
            size: 24.sp,
          ),
          iconSize: 24.sp,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
