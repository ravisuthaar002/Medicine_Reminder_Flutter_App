import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';

import '../../../data/response/app_exceptions.dart';
import '../../../utils/utils.dart';

class SignupViewModal extends GetxController{


  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool obsecurePassword = true.obs;
  RxBool isChecked = false.obs;
  RxBool loading = false.obs;

  signup()async {
    loading.value = true;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text);

      Get.toNamed(RoutesName.verifyEmail);

    }on SocketException{
      throw InternetException('');
    } on RequestTimeOut{
      throw RequestTimeOut('');
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found for that email.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password. Please try again.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        default:
          errorMessage = "Login failed. ${e.message}";
      }

      Utils.toastMessageTop(errorMessage);
    } catch (e) {

      Utils.toastMessageTop("An error occurred. Please try again.");

    }
    loading.value = false;
  }
}