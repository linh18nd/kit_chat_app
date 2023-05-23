import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/app_controller/app_controller.dart';
import 'package:kit_chat_app/persenstation/app_theme/theme_export.dart';
import 'package:kit_chat_app/persenstation/view/splash/controller/splash_controller.dart';
import 'package:kit_chat_app/persenstation/widget/app_loading_widget.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      child: Center(
        child: Obx(
          () {
            if (controller.loadedType.value == LoadedType.start) {
              return AppLoadingWidget(
                width: 56.w,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
