

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicine_reminder_flutter_app/utils/utils.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/login/login_view_modal.dart';

import '../../wrapper.dart';

class LoginRepository{

  final _formKey = GlobalKey<FormState>();
  final LoginViewModal loginViewModal;

  LoginRepository(this.loginViewModal);

  Future<dynamic> loginApi(var data)async{
    if (_formKey.currentState!.validate()) return;
    if (_formKey.currentState!.validate()) return;


      loginViewModal.loading.value = true;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginViewModal.emailController.value.toString(),
        password: loginViewModal.passwordController.value.toString(),
      );
      Get.offAll(Wrapper());
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

     Utils.toastMessage(errorMessage);

    } catch (e) {

      Utils.toastMessage("An error occurred. Please try again.");

    }

      loginViewModal.loading.value = false;

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