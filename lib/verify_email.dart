import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medicine_reminder_flutter_app/signup_page.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/login/wrapper_view_modal.dart';

class Verify_email extends StatefulWidget{
  const Verify_email({super.key});

  @override
  State<Verify_email> createState() => _Verify_emailState();
}

class _Verify_emailState extends State<Verify_email> {

  @override
  void initState() {
    sendverifylink();
    super.initState();
  }

  sendverifylink()async{
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value)=>{
      Get.snackbar('Link send','A link has been send to your email',margin: EdgeInsets.all(30),snackPosition: SnackPosition.BOTTOM)
    });
  }

  final emailset = Signup_page();

  bool isloading = false;

  reload()async{
    setState(() {
      isloading = true;
    });
    // await FirebaseAuth.instance.currentUser!.reload().then((value) => {Get.offAll(Wrapper())});
    await FirebaseAuth.instance.currentUser!.reload();
    var user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      FirebaseFirestore.instance.collection(user!.uid).doc("user data").set({

      }).then((value){
        log("Data Inserted");
      });
      // Get.offAll(() => Wrapper());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Wrapper()));
    } else {
      Get.snackbar(
        "Not Verified",
        "Please verify your email before proceeding.",
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(20),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading?Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 24,color: Colors.white),
        backgroundColor: Colors.orange.shade800,
        title: Text('Verify Email',style: TextStyle(fontSize: 24,color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
             padding: EdgeInsets.all(30),
             child: Center(
                child: Text('We’ve sent a verification link to your email and reload this page.',style: TextStyle(fontSize: 22),),
      ),
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade800,
          onPressed: (() => reload()),
        child: Icon(Icons.restart_alt_rounded,color: Colors.white,),
      ),

    );
  }
}