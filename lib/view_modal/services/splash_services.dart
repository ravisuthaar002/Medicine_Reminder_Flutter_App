

import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../res/routes/routes_name.dart';
import '../controller/user_preference/user_preference_view_modal.dart';

class SplashServices{

  UserPreference userPreference = UserPreference();

  void isLogin(){

    userPreference.getUser().then((value){
      if (value.token == null || value.token!.isEmpty) {
        Timer(const Duration(seconds: 3),
                () => Get.toNamed(RoutesName.loginView));
      }else{
        Timer(const Duration(seconds: 3),
                () => Get.toNamed(RoutesName.homePage));
      }
    });

  }
}