import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../route/app_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? _) {
        return GetMaterialApp(
          title: 'Kit Chat App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: AppRoute.initial,
          getPages: AppRoute.routes,
        );
      },
    );
  }
}
