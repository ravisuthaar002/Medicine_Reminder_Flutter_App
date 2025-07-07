import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';

import '../../res/colors/app_colors.dart';
import '../../utils/utils.dart';
import '../../view_modal/controller/login/login_view_modal.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginViewModal loginViewModal = LoginViewModal();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 70),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login to your account.',style: TextStyle(fontSize: AppFontSize.large,fontWeight: FontWeight.bold),),
                Text('Please sign in to your account',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.black54),),
                SizedBox(height: 30),
                Align(alignment: Alignment.center, child: Text("Welcome Back 👋", style: TextStyle(fontSize: AppFontSize.medium, fontWeight: FontWeight.bold))),
                SizedBox(height: 50),

                Text('Email Address',style: TextStyle(fontSize: AppFontSize.small),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: loginViewModal.emailController.value,
                  focusNode: loginViewModal.emailFocusNode.value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          BorderSide(width: 2, color: Colors.orange.shade800)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 2, color: AppColors.grey))
                  ),
                  onFieldSubmitted: (value){
                    Utils.fieldFocusChange(context, loginViewModal.emailFocusNode.value, loginViewModal.passwordFocusNode.value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter email';
                    else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
                      return 'Enter valid email';
                    return null;
                  },
                ),
                SizedBox(height: 30),

                Text('Password',style: TextStyle(fontSize: AppFontSize.small),),
                SizedBox(height: 10,),
                Obx(() =>
                TextFormField(
                  controller: loginViewModal.passwordController.value,
                  obscureText: loginViewModal.obsecurePassword.value,
                  focusNode: loginViewModal.passwordFocusNode.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        BorderSide(width: 2, color: AppColors.orange800)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 2, color: AppColors.grey)),
                    suffixIcon: IconButton(
                      icon: Icon(loginViewModal.obsecurePassword.value ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                          loginViewModal.obsecurePassword.value = !loginViewModal.obsecurePassword.value;
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter password';
                    else if (value.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                )),
                TextButton(onPressed: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => Forgot()));
                } , child: Text('Forgot password?',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.orange800),)),
                SizedBox(height: 50),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange800,
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 40)),
                    onPressed: () {
                      // logIn();
                      if (_formkey.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text("Logging in...")),
                        // );
                      }
                    },
                    child: loginViewModal.loading.value ? CircularProgressIndicator() : Text("Log In",style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.white)),
                  ),
                ),
                SizedBox(height: 20,),

                Center(
                  child: TextButton(
                      //onPressed: (()=>signIn()),
                      onPressed: () {  },
                      child: Text('Sign In with Google',style: TextStyle(fontSize: AppFontSize.small,color: AppColors.orange800),)),
                ),

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don`t have an account?',style: TextStyle(fontSize: AppFontSize.small),),
                    TextButton(onPressed: (){
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_page()));
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
