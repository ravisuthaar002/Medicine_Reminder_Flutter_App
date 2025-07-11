


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/utils/utils.dart';

class ForgotPasswordViewModal extends GetxController{

  final emailController = TextEditingController();
  RxBool loading = false.obs;

  reset() async {
    loading.value = true;
    try {

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.value.text);

      loading.value = false;
      // Show success message
      Utils.toastMessageTop('Password reset email sent!');
    } catch (e) {
      // Show error message
      loading.value = false;
      Utils.toastMessageTop('Error: ${e.toString()}');
    }
  }
}