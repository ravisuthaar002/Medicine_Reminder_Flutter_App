

import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/home_page.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';
import 'package:medicine_reminder_flutter_app/view/home_pages/add_medicine_view.dart';
import 'package:medicine_reminder_flutter_app/view/home_pages/calendar_view.dart';
import 'package:medicine_reminder_flutter_app/view/home_pages/horizontalDateSelector_view.dart';
import 'package:medicine_reminder_flutter_app/view/home_pages/threeline_menu_page.dart';
import 'package:medicine_reminder_flutter_app/view/login/forgot_password.dart';
import 'package:medicine_reminder_flutter_app/view/login/phone_verify/otp_verification_view.dart';
import 'package:medicine_reminder_flutter_app/view/login/personal_data_view.dart';
import 'package:medicine_reminder_flutter_app/view/login/phone_verify/verify_email_view.dart';
import 'package:medicine_reminder_flutter_app/view/login/signup_view.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/login/wrapper_view_modal.dart';

import '../../view/login/login_view.dart';
import '../../view/splash_screen.dart';


class AppRoutes{

  static appRoutes() => [
    GetPage(
        name: RoutesName.wrapper,
        page: () => Wrapper(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
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
        name: RoutesName.signupView,
        page: () => SignupPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.verifyEmail,
        page: () => VerifyEmail(),
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
    GetPage(
        name: RoutesName.homePage,
        page: () => HomePage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.addMedicinePage,
        page: () => AddMedicinePage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.calenderPage,
        page: () => CalendarView(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
    GetPage(
        name: RoutesName.horizontalDateSelector,
        page: () {
        final Function(DateTime) onDateSelected = Get.arguments['onDateSelected'];
        return HorizontalDateSelector(onDateSelected: onDateSelected);
        },
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(
        name: RoutesName.threeLineMenu,
        page: () => ThreeLineMenuPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 250)
    ),
  ];
}