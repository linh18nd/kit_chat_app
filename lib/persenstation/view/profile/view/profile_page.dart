import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_theme/color_theme.dart';
import 'package:kit_chat_app/persenstation/view/profile/controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAvatar(),
            SizedBox(height: 16.h),
            _buildProfileItem(
              icon: Icons.person,
              text: controller.user!.username,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            _buildProfileItem(
              icon: Icons.email,
              text: controller.user!.email,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.h),
            _buildProfileItem(
              icon: Icons.group,
              text: '${controller.user!.friends.length} friends',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.divider,
          width: 1.w,
        ),
      ),
      child: CircleAvatar(
        radius: 80,
        backgroundImage: NetworkImage(controller.user!.avatarUrl),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String text,
    required TextStyle style,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(width: 8.w),
        Text(
          text,
          style: style,
        ),
      ],
    );
  }
}
