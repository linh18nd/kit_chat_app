import 'package:get/get.dart';

class MainCotroller extends GetxController {
  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  void changeIndex(int index) => _selectedIndex.value = index;
  //kiểm tra đăng nhập hay để hiển thị trong home hay login
  final _isLogin = false.obs;
}
