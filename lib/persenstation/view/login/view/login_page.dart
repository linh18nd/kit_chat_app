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
            icon: AssetPath.iconGoogle,
            title: 'Login with Google',
            onPressed: () {
              controller.login(AuthencationType.google);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(
      {required String icon,
      required String title,
      required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10.h,
          top: 10.h,
          left: 30.w,
          right: 30.w,
        ),
        height: 50.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.divider,
            width: 1,
          ),
          color: AppColors.primaryColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
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
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
