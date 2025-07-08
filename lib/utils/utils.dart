

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../res/colors/app_colors.dart';

class Utils{

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.black54,
        gravity: ToastGravity.BOTTOM
    );
  }


  static toastMessageCenter(String message){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.orange800,
        textColor: AppColors.white,
        gravity: ToastGravity.CENTER
    );
  }
  static toastMessageTop(String message){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.orange800,
        textColor: AppColors.white,
        gravity: ToastGravity.TOP,

    );
  }

  static snackBar(String title, String message){
    Get.snackbar(
      title,
      message,

    );
  }
}