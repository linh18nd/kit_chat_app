import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/bindings/chat_view_binding.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/view/chat_view.dart';
import 'package:kit_chat_app/persenstation/view/home/bindings/home_binding.dart';
import 'package:kit_chat_app/persenstation/view/home/view/home_page.dart';
import 'package:kit_chat_app/persenstation/view/login/bindings/login_binding.dart';
import 'package:kit_chat_app/persenstation/view/login/view/login_page.dart';
import 'package:kit_chat_app/persenstation/view/main/bindings/main_binding.dart';
import 'package:kit_chat_app/persenstation/view/main/view/main_page.dart';
import 'package:kit_chat_app/persenstation/view/search/bindings/search_binding.dart';
import 'package:kit_chat_app/persenstation/view/search/view/search_page.dart';
import 'package:kit_chat_app/persenstation/view/splash/bindings/splash_binding.dart';
import 'package:kit_chat_app/persenstation/view/splash/view/splash_page.dart';

class AppRoute {
  static const String initial = Path.spalsh;
  static List<GetPage> routes = [
    GetPage(
      name: Path.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Path.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Path.spalsh,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Path.main,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Path.search,
      page: () => const SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
        name: Path.chat, page: () => const ChatPage(), binding: ChatBinding()),
  ];
}

class Path {
  static const String home = '/home';
  static const String login = '/login';
  static const String spalsh = '/splash';
  static const String main = '/main';
  static const String search = '/search';
  static const String chat = '/chat';
}
