import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medicine_reminder_flutter_app/res/colors/app_colors.dart';
import 'package:medicine_reminder_flutter_app/res/components/email_input_filed.dart';
import 'package:medicine_reminder_flutter_app/res/components/password_input_filed.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/login/signup_view_modal.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final SignupViewModal loginViewModal = SignupViewModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 24),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create your new account',style: TextStyle(fontSize: AppFontSize.large, fontWeight: FontWeight.bold),),
                Text('Create an account to start finding the care',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.black54),),

                // Spacer(),
                SizedBox(height: Get.height * .05,),
                Text('Email Address',style: TextStyle(fontSize: AppFontSize.small),),
                SizedBox(height: Get.height * .01,),
                EmailInputFiled(
                    controller: loginViewModal.emailController,
                    focusNode: loginViewModal.emailFocusNode.value,
                    nextFocusNode: loginViewModal.passwordFocusNode.value),
                SizedBox(height: Get.height * .03,),

                Text('Password',style: TextStyle(fontSize: AppFontSize.small),),
                SizedBox(height: Get.height * .01,),
                PasswordInputFiled(
                    controller: loginViewModal.passwordController,
                    obscureText: loginViewModal.obsecurePassword,
                    focusNode: loginViewModal.passwordFocusNode.value),
                SizedBox(height: Get.height * .02,),
                Row(
                  children: [
                    Obx(()=>
                    Checkbox(
                      value: loginViewModal.isChecked.value,
                      onChanged: (bool? value) {
                          loginViewModal.isChecked.value = value!;
                      },
                      activeColor: AppColors.orange800,
                    )),
                    Expanded(
                      child: Text('I Agree with Terms of Service and Privacy Policy ',
                        style: TextStyle(fontSize: AppFontSize.small),
                      ),
                    )
                  ],
                ),
                // Spacer(),
                SizedBox(height: Get.height * .04,),
                Center(
                  child: Obx(()=> ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange800,
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 40)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginViewModal.signup();
                      }
                    },
                    child: loginViewModal.loading.value ?
                        CircularProgressIndicator(color: AppColors.white,) :
                    Text("Register",style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.white)),
                  )),
                ),
                // Spacer(),

                SizedBox(height: Get.height * .05),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don`t have an account?',style: TextStyle(fontSize: AppFontSize.small),),
                    TextButton(onPressed: (){
                      Get.offAllNamed(RoutesName.loginView);
                    }, child: Text('Sign in',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.orange800),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}