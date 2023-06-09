import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kit_chat_app/persenstation/app_theme/theme_export.dart';

class AppLoadingWidget extends StatelessWidget {
  final double? width;

  const AppLoadingWidget({
    Key? key,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 56.w,
      height: width ?? 56.w,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: CircularProgressIndicator(
        strokeWidth: 4.w,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentColor),
      ),
    );
  }
}
