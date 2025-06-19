import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget{
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  // bool isloading = false;

  reset()async{
    // setState(() {
    //   isloading = true;
    // });
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
    // setState(() {
    //   isloading = false;
    // });
  }

  // isloading?Center(child: CircularProgressIndicator(),) :

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 24),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 70),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forgot password?',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              Text('Enter your email address and we’ll send you confirmation code to reset your password',style: TextStyle(fontSize: 14,color: Colors.black54),),
              SizedBox(height: 30),

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
                    return 'Please enter valid email';
                  return null;
                },
              ),
              SizedBox(height: 50),

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade800,
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 40)),
                  onPressed: () {
                    reset();
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text("Send Email",style: TextStyle(fontSize: 20,color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}