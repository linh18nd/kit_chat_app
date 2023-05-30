import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/domain/usecases/user_usecase.dart';
import 'package:kit_chat_app/route/app_route.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final userModelUsecase = getIt<UserModelUsecase>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // if (state == AppLifecycleState.resumed) {
    //   log('Ứng dụng đã được mở');
    //   if (auth.currentUser != null) {
    //     await userModelUsecase.updateStatus(auth.currentUser!.uid, true);
    //   }
    // } else if (state == AppLifecycleState.paused) {
    //   log('Ứng dụng đã bị đóng');
    //   log(auth.currentUser!.uid);
    //   if (auth.currentUser != null) {
    //     await userModelUsecase.updateStatus(auth.currentUser!.uid, false);
    //   }
    // }
  }

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
