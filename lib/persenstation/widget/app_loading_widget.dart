import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kit_chat_app/persenstation/app_theme/theme_export.dart';

class AppLoadingWidget extends StatelessWidget {
  final double? width;

  AppLoadingWidget({
    Key? key,
    double? width,
  })  : width = width ?? 56.w,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: CircularProgressIndicator(
          strokeWidth: 4.w,
          valueColor:
              const AlwaysStoppedAnimation<Color>(AppColors.accentColor),
        ));
  }
}
