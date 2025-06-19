import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_flutter_app/login_page.dart';
import 'package:medicine_reminder_flutter_app/verify_email.dart';

class Signup_page extends StatefulWidget{
  const Signup_page({super.key});

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;

  bool isChecked = false;

  bool isloading = false;

  signup()async{
    setState(() {
      isloading = true;
    });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    print("a");
    // Get.offAll(Wrapper());
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Verify_email()));
    print("a");

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading?Center(child: CircularProgressIndicator(),) : Scaffold(
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
                Text('Create your new account',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                Text('Create an account to start finding the care',style: TextStyle(fontSize: 14,color: Colors.black54),),
        
                // Spacer(),
                SizedBox(height: 50,),
                Text('Email Address',style: TextStyle(fontSize: 14),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          BorderSide(width: 3, color: Colors.orange.shade800)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 3, color: Colors.grey))
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter email';
                    else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
                      return 'Enter valid email';
                    return null;
                  },
                ),
                SizedBox(height: 40,),

                Text('Password',style: TextStyle(fontSize: 14),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        BorderSide(width: 3, color: Colors.orange.shade800)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 3, color: Colors.grey)),
                    suffixIcon: IconButton(
                      icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
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
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: Colors.orange.shade800,
                    ),
                    Expanded(
                      child: Text('I Agree with Terms of Service and Privacy Policy ',
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
                // Spacer(),
                SizedBox(height: 70,),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 40)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text("Logging in...")),
                        // );
                      }
                      signup();
                    },
                    child: Text("Register",style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                ),
                // Spacer(),
        
                SizedBox(height: 60,),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don`t have an account?',style: TextStyle(fontSize: 14),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login_page()));
                    }, child: Text('Sign in',style: TextStyle(fontSize: 14,color: Colors.orange.shade800),))
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