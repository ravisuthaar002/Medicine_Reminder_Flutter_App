

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';

import '../../../data/response/app_exceptions.dart';
import '../../../utils/utils.dart';
import 'wrapper_view_modal.dart';
import '../user_preference/user_preference_view_modal.dart';

class LoginViewModal extends GetxController{


  RxBool obsecurePassword = true.obs;
  RxBool loading = false.obs;

  var userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;



  Future<dynamic> loginApi()async{


    loading.value = true;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.value.toString(),
        password: passwordController.value.toString(),
      );
      Get.offAllNamed(RoutesName.wrapper);                   
    } on SocketException{
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



  Future<dynamic> signIn()async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}