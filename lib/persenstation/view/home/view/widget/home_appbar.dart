import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/persenstation/app_theme/color_theme.dart';
import 'package:kit_chat_app/route/app_route.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    required this.user,
    this.onLogout,
    required this.onSearch,
  }) : super(key: key);

  final UserModel? user;
  final VoidCallback? onLogout;
  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      toolbarHeight: 56.h,
      elevation: 0,
      title: const Text(
        "Cuộc trò chuyện",
        style: TextStyle(
          color: AppColors.textSecondary,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Get.toNamed(AppPath.profile, arguments: user);
        },
        child: Container(
          margin: EdgeInsets.only(left: 16.w),
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.divider,
              width: 2.0,
            ),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user?.avatarUrl ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      actions: [
        // IconButton(
        //   onPressed: onSearch,
        //   icon: const Icon(
        //     Icons.search,
        //     color: AppColors.iconColor,
        //   ),
        //   iconSize: 24.sp,
        // ),
        // IconButton(
        //   onPressed: onLogout,
        //   icon: Icon(
        //     Icons.logout,
        //     color: AppColors.iconColor,
        //     size: 24.sp,
        //   ),
        //   iconSize: 24.sp,
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
