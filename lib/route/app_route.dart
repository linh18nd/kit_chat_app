import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/call/bindings/call_binding.dart';
import 'package:kit_chat_app/persenstation/view/call/view/call_view.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/bindings/chat_view_binding.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/view/chat_view.dart';
import 'package:kit_chat_app/persenstation/view/friend/bindings/friend_binding.dart';
import 'package:kit_chat_app/persenstation/view/friend/views/friend_page.dart';
import 'package:kit_chat_app/persenstation/view/home/bindings/home_binding.dart';
import 'package:kit_chat_app/persenstation/view/home/view/home_page.dart';
import 'package:kit_chat_app/persenstation/view/login/bindings/login_binding.dart';
import 'package:kit_chat_app/persenstation/view/login/view/login_page.dart';
import 'package:kit_chat_app/persenstation/view/main/bindings/main_binding.dart';
import 'package:kit_chat_app/persenstation/view/main/view/main_page.dart';
import 'package:kit_chat_app/persenstation/view/profile/bindings/profile_binding.dart';
import 'package:kit_chat_app/persenstation/view/profile/view/profile_page.dart';
import 'package:kit_chat_app/persenstation/view/search/bindings/search_binding.dart';
import 'package:kit_chat_app/persenstation/view/search/view/search_page.dart';
import 'package:kit_chat_app/persenstation/view/splash/bindings/splash_binding.dart';
import 'package:kit_chat_app/persenstation/view/splash/view/splash_page.dart';

class AppRoute {
  static const String initial = AppPath.spalsh;
  static List<GetPage> routes = [
    GetPage(
      name: AppPath.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppPath.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppPath.spalsh,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppPath.main,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppPath.search,
      page: () => const SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppPath.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppPath.friend,
      page: () => const FriendPage(),
      binding: FriendBinding(),
    ),
    GetPage(
      name: AppPath.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppPath.call,
      page: () => const CallPage(),
      binding: CallBinding(),
    ),
  ];
}

class AppPath {
  static const String home = '/home';
  static const String login = '/login';
  static const String spalsh = '/splash';
  static const String main = '/main';
  static const String search = '/search';
  static const String chat = '/chat';
  static const String friend = '/friend';
  static const String profile = '/profile';

  static const String imagePreview = '/imagePreview';
  static const String call = '/call';
}
