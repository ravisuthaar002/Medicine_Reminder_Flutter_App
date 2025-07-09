
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';

import '../../../res/colors/app_colors.dart';
import '../../../view_modal/controller/login/verify_email_view_modal.dart';

class VerifyEmail extends StatefulWidget{
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  final verifyEmailViewModal = Get.put(VerifyEmailViewModal());

  @override
  void initState() {
    verifyEmailViewModal.sendVerifyLink();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: AppFontSize.mediumPlus,color: AppColors.white),
        backgroundColor: AppColors.orange800,
        title: Text('Verify Email',style: TextStyle(fontSize: AppFontSize.mediumPlus,color: AppColors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Text('We’ve sent a verification link to your email and reload this page.',style: TextStyle(fontSize: AppFontSize.mediumPlus),),
        ),
      ),
       floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange800,
        onPressed: (() => verifyEmailViewModal.reload()),
        child:Obx(() => verifyEmailViewModal.loading.value ?
            CircularProgressIndicator(color: AppColors.white,) :
            Icon(Icons.restart_alt_rounded,color: AppColors.white,),
      )),

    );
  }
}