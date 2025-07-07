

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../modal/login/user_modal.dart';
import '../../../repository/login_repository/login_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_preference_view_modal.dart';

class LoginViewModal extends GetxController{

  final _api = LoginRepository();

  RxBool obsecurePassword = true.obs;
  RxBool loading = false.obs;

  UserPreference userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  void loginApi(){
    loading.value = true;
    Map data = {
      "email": emailController.value.text,
      "password": passwordController.value.text,
    };
    _api.loginApi(data).then((value){
      loading.value = false;
      if(value['error'] == 'user not found'){
        Utils.snackBar('Login', value['error']);
      }else {
        userPreference.saveUser(UserModal.fromJson(value)).then((value){
          Get.toNamed(RoutesName.homePage);
        }).onError((error, stackTrace){

        });

        Utils.snackBar('Login', 'Login successfully');
      }
    }).onError((error,stackTrace){
      print(error.toString());
      loading.value = false;
      Utils.snackBar('Error', error.toString());
    });
  }
}