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
