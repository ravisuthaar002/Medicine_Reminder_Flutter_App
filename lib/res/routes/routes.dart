

import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/home_page.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';

import '../../view/login/login_view.dart';
import '../../view/splash_screen.dart';


class AppRoutes{

  static appRoutes() => [
    GetPage(
        name: RoutesName.splashScreen,
        page: () => SplashScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.loginView,
        page: () => LoginView(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.homePage,
        page: () => HomePage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
  ];
}