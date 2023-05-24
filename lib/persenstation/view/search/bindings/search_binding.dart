import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/search/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchPageController>(() => SearchPageController());
  }
}
