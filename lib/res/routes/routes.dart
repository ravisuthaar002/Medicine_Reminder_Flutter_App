

import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/home_page.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';
import 'package:medicine_reminder_flutter_app/view/login/forgot_password.dart';
import 'package:medicine_reminder_flutter_app/view/login/phone_verify/otp_verification_view.dart';
import 'package:medicine_reminder_flutter_app/view/login/personal_data_view.dart';
import 'package:medicine_reminder_flutter_app/view/login/signup_view.dart';

import '../../verify_email.dart';
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
    GetPage(
        name: RoutesName.signupView,
        page: () => SignupPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.verifyEmail,
        page: () => Verify_email(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.forgotPassword,
        page: () => ForgotPassword(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.personalData,
        page: () => PersonalDataPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
      name: RoutesName.phoneVerification,
      page: () {
        final args = Get.arguments;
        return OtpVerificationView(
          verificationid: args['verificationid'],
          name: args['name'],
          dob: args['dob'],
          phone: args['phone'],
          gender: args['gender'],
        );
      },
    ),
  ];
}