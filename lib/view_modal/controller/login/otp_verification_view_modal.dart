
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';

class OtpVerificationViewModal extends GetxController {
  late String name, phone, dob, gender, verificationId;

  void init({
    required String name,
    required String phone,
    required String dob,
    required String gender,
    required String verificationId,
  }) {
    this.name = name;
    this.phone = phone;
    this.dob = dob;
    this.gender = gender;
    this.verificationId = verificationId;

    startTimer();
  }

  final otpController = TextEditingController();
  RxBool loading = false.obs;
  RxInt resendTime = 60.obs;
  RxBool isResendEnabled = false.obs;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendTime.value > 0) {
        resendTime.value--;
      } else {
        isResendEnabled.value = true;
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtp() async {
    if (otpController.text.trim().length != 6) {
      Utils.toastMessage("Please enter a valid 6-digit OTP");
      return;
    }

    loading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      await addUserData();
      Get.offAllNamed(RoutesName.homePage);
    }on FirebaseAuthException catch (e) {
      String errorMessage = "";

      if (e.code == 'invalid-verification-code') {
        errorMessage = "The OTP you entered is incorrect.";
      } else if (e.code == 'session-expired') {
        errorMessage = "The OTP has expired. Please request a new one.";
      } else {
        errorMessage = "OTP verification failed. Please try again.";
      }
      Utils.toastMessageTop(errorMessage);
    }catch (e) {
      Utils.toastMessageTopRed("Verification failed. Try again.");
    }
    loading.value = false;
  }

  Future<void> addUserData() async {
    final user = FirebaseAuth.instance.currentUser;
     await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'name': name,
      'phone': phone,
      'dob': dob,
      'gender': gender,
    });
  }

  @override
  void onInit() {
    super.onInit();

    // Get phone from arguments
    phone = Get.arguments['phone'] ?? '';

    if (phone.isEmpty) {
      // optional: throw error or log
      Utils.toastMessageTopRed("Phone number not passed to OTP");
    }
  }

  void resendOTP() async {


    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91$phone",
      timeout: Duration(seconds: 90),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Utils.toastMessageTop("OTP resend failed");
      },
      codeSent: (String newVerificationId, int? resendToken) {
        verificationId = newVerificationId;
        Utils.toastMessageTop("OTP resent successfully");
        // Restart the timer
        resendTime.value = 60;
        startTimer();
        isResendEnabled.value = false;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

}
