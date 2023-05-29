import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoadedType {
  start,
  end,
}

mixin AppController {
  BuildContext? context;

  Rx<LoadedType> loadedType = LoadedType.end.obs;
}

class AppActivityController extends GetxController with WidgetsBindingObserver {
  RxBool isActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }
}
