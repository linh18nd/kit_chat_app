import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/home/bindings/home_binding.dart';
import 'package:kit_chat_app/persenstation/view/home/view/home_page.dart';
import 'package:kit_chat_app/persenstation/view/login/bindings/login_binding.dart';
import 'package:kit_chat_app/persenstation/view/login/view/login_page.dart';
import 'package:kit_chat_app/persenstation/view/main/bindings/main_binding.dart';
import 'package:kit_chat_app/persenstation/view/main/view/main_page.dart';
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
  ];
}

class Path {
  static const String home = '/home';
  static const String login = '/login';
  static const String spalsh = '/splash';
  static const String main = '/main';
}
