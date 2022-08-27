import 'package:get/get.dart';
import 'package:salondec/bindings/auth_binding.dart';
import 'package:salondec/menu/loginScreen.dart';
import 'package:salondec/page/mainPage.dart';

class PageRouter {
  PageRouter._();

  static const initial = LoginScreen.routeName;

  static final routes = [
    GetPage(
      name: LoginScreen.routeName,
      page: () => LoginScreen(),
      bindings: [AuthBinding()],
    ),
    GetPage(
      name: MainPage.routeName,
      page: () => MainPage(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: MainPage.routeName,
      page: () => MainPage(),
    ),
  ];
}
