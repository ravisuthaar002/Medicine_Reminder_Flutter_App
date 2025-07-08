import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medicine_reminder_flutter_app/res/colors/app_colors.dart';
import 'package:medicine_reminder_flutter_app/res/components/email_input_filed.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/login/forgot_password_view_modal.dart';

class ForgotPassword extends StatefulWidget{
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final forgotPasswordViewModal = ForgotPasswordViewModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 24),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 70),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Forgot password?',style: TextStyle(fontSize: AppFontSize.large,fontWeight: FontWeight.bold),),
                Text('Enter your email address and we’ll send you confirmation code to reset your password',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.black54),),
                SizedBox(height: Get.height * .05,),

                Text('Email Address',style: TextStyle(fontSize: AppFontSize.small),),
                SizedBox(height: Get.height * .01,),

                EmailInputFiled(controller: forgotPasswordViewModal.emailController.value),

                SizedBox(height: Get.height * .07,),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange800,
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 40)),
                    onPressed: () {
                      forgotPasswordViewModal.reset();
                      if (_formKey.currentState!.validate()) {}
                    },
                    child:Obx(()=> forgotPasswordViewModal.loading.value ?
                        CircularProgressIndicator() :
                        Text("Send Email",style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.white)),
                  ),
                ),
               )
             ],),
          ),
        ),
      ),
    );
  }
}