import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/res/components/email_input_filed.dart';
import 'package:medicine_reminder_flutter_app/res/components/password_input_filed.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';

import '../../res/colors/app_colors.dart';
import '../../view_modal/controller/login/login_view_modal.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final LoginViewModal loginViewModal = LoginViewModal();


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 70),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login to your account.',style: TextStyle(fontSize: AppFontSize.large,fontWeight: FontWeight.bold),),
                Text('Please sign in to your account',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.black54),),
                SizedBox(height: Get.height * .03,),
                Align(alignment: Alignment.center, child: Text("Welcome Back 👋", style: TextStyle(fontSize: AppFontSize.medium, fontWeight: FontWeight.bold))),
                SizedBox(height: Get.height * .04,),

                Text('Email Address',style: TextStyle(fontSize: AppFontSize.small),),
                SizedBox(height: Get.height * .01,),
                EmailInputFiled(
                    controller: loginViewModal.emailController,
                    focusNode: loginViewModal.emailFocusNode,
                    nextFocusNode: loginViewModal.passwordFocusNode),
                SizedBox(height: Get.height * .02,),

                Text('Password',style: TextStyle(fontSize: AppFontSize.small),),
                SizedBox(height: Get.height * .01,),
                PasswordInputFiled(
                    controller: loginViewModal.passwordController,
                    obscureText: loginViewModal.obsecurePassword,
                    focusNode: loginViewModal.passwordFocusNode,),

                TextButton(onPressed: (){
                 Get.toNamed(RoutesName.forgotPassword);
                } , child: Text('Forgot password?',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.orange800),)),
                SizedBox(height: Get.height * .03,),


                   Center(
                     child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange800,
                          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 40)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginViewModal.loginApi();
                          }
                      },
                      child: loginViewModal.loading.value ?
                       CircularProgressIndicator(color: AppColors.white,) :
                       Text("Log In",style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.white)),
                     ),
                    ),
                   ),

                SizedBox(height: Get.height * .03,),

                Center(
                  child: TextButton(
                      onPressed: (()=>loginViewModal.signIn()),
                      child: Text('Sign In with Google',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.orange800),)),
                ),

                SizedBox(height: Get.height * .02,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don`t have an account?',style: TextStyle(fontSize: AppFontSize.small),),
                    TextButton(onPressed: (){
                    Get.offAllNamed(RoutesName.signupView);
                    }, child: Text('Register',style: TextStyle(fontSize: 14,color: AppColors.orange800),))
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
