import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/app_path.dart/app_path.dart';
import 'package:kit_chat_app/domain/repositories/authencation_repository.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/app_theme/theme_export.dart';
import 'package:kit_chat_app/persenstation/view/login/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.loadedType.value == LoadedType.start
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAppLogo(),
                    _buildLoginSocial(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Expanded(
      flex: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetPath.appLogo,
            width: 200.w,
            height: 200.w,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Kit Chat',
            style: AppTextStyles.title,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginSocial(context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          _buildLoginButton(
            authenticationType: AuthencationType.google,
            icon: AssetPath.iconGoogle,
            title: 'Login with Google',
            onPressed: () {
              controller.login(AuthencationType.google);
            },
          ),
          _buildLoginButton(
            authenticationType: AuthencationType.facebook,
            icon: AssetPath.iconFacebook,
            title: 'Login with Facebook',
            onPressed: () {
              controller.login(AuthencationType.facebook);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton({
    required String icon,
    required String title,
    required VoidCallback onPressed,
    required AuthencationType authenticationType,
  }) {
    Color backgroundColor;
    if (authenticationType == AuthencationType.facebook) {
      backgroundColor = const Color(0xFF4267B2);
    } else if (authenticationType == AuthencationType.google) {
      backgroundColor = Colors.white;
    } else {
      backgroundColor = Colors.transparent;
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.r,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 20.w,
              height: 20.w,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: authenticationType == AuthencationType.facebook
                    ? Colors.white
                    : Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
