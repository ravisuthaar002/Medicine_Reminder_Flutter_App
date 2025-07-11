

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../res/routes/routes_name.dart';

class PersonalDataViewModal extends GetxController{
  final _formKey = GlobalKey<FormState>();

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    return null;
  }


  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final selecterFocusNode = FocusNode();
  final dobFocusNode = FocusNode();

  RxString selectedGender = 'Male'.obs;
  RxList<String> genderList = ['Male', 'Female', 'Other'].obs;

  RxBool loading = false.obs;

  send()async{
      loading.value = true;
      await FirebaseAuth.instance.verifyPhoneNumber(
          verificationCompleted:
              (PhoneAuthCredential credential) {print("Verification completed");},
          verificationFailed: (FirebaseAuthException ex) {print("Verification failed: ${ex.message}");},
          codeSent: (String verificationid, int? resendtoken) {
            print("OTP sent. Verification ID: ${verificationid}");

            Get.toNamed(RoutesName.phoneVerification,
              arguments: {
                'verificationid': verificationid,
                'name': nameController.text.trim(),
                'dob': dobController.text.trim(),
                'phone': phoneController.text ,
                'gender': selectedGender?.value ?? 'Not selected',
              },
            );
            loading.value = false;
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          phoneNumber: '+91${phoneController.value.text.toString()}'
      );

  }
}