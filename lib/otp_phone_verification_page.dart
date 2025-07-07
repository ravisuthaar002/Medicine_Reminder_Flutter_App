import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'home_page.dart';

class Otp_Verification_Page extends StatefulWidget{
  String verificationid;
  var name;
  var dob;
  var phone;
  var gender;
  Otp_Verification_Page({super.key, required this.verificationid, required this.name, required this.dob, required this.phone, required this.gender});

  @override
  State<Otp_Verification_Page> createState() => _Otp_Verification_PageState();
}

class _Otp_Verification_PageState extends State<Otp_Verification_Page> {

  int resendTime = 60;
  bool isResendEnabled = false;
  Timer? _timer;

  void startTimer() {
    resendTime = 60;
    isResendEnabled = false;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (resendTime > 0) {
          resendTime--;
        } else {
          isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  void resendOTP() async {
    startTimer(); // Restart the timer

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${widget.phone}",
      timeout: Duration(seconds: 90),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("OTP resend failed"),
          backgroundColor: Colors.red,
        ));
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          widget.verificationid = verificationId;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("OTP resent successfully"),
          backgroundColor: Colors.green,
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start timer when screen loads
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }




  var otpController = TextEditingController();

adddata()async{
  final user = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance.collection(user!.uid).doc("user_data").set({
    "Name":  widget.name,
    "Phone Number":  widget.phone,
    "Date of Birth":  widget.dob,
    "Gender":   widget.gender,
  }).then((value){
    log("Data Inserted");
  });
}

  bool isloading = false;

verify()async{


  if (otpController.text.trim().length != 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Please enter a valid 6-digit OTP"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  setState(() {
    isloading = true;
  });

  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationid,
      smsCode: otpController.text.trim(),
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    await adddata();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } on FirebaseAuthException catch (e) {
    String errorMessage = "";

    if (e.code == 'invalid-verification-code') {
      errorMessage = "The OTP you entered is incorrect.";
    } else if (e.code == 'session-expired') {
      errorMessage = "The OTP has expired. Please request a new one.";
    } else {
      errorMessage = "OTP verification failed. Please try again.";
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    ));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Something went wrong. Try again."),
      backgroundColor: Colors.red,
    ));
  }

  setState(() {
    isloading = false;
  });

}


  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.orange.shade800),
      borderRadius: BorderRadius.circular(14),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.black12,
      ),
    );
    return isloading?Center(child: CircularProgressIndicator(),) : Scaffold(
        body: SingleChildScrollView(
        child: ConstrainedBox(
         constraints: BoxConstraints(
         minHeight: MediaQuery.of(context).size.height,
        ),
          child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('OTP Verification',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900),),

                SizedBox(height: 20,),
                Text('Enter the verification code we just sent on your phone number: +91 ${widget.phone}  ',style: TextStyle(fontSize: 14),),
                SizedBox(height: 20,),
                Center(
                  child: Pinput(
                    controller: otpController,
                    length: 6,
                   defaultPinTheme: defaultPinTheme,
                   focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    validator: (s) {
                      if (s == null || s.length < 6) {
                        return 'Enter valid OTP';
                      }
                      return null;
                    },
                  // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                   ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8)
                    ),
                    onPressed: (){
                      verify();
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Verify',style: TextStyle(color: Colors.white,fontSize: 18),),
                        Icon(Icons.arrow_forward,color: Colors.white,size: 25,)
                      ],
                    ) ),

                Container(height: 20,),

                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isResendEnabled
                          ? TextButton(
                        onPressed: resendOTP,
                        child: Text('Resend OTP', style: TextStyle(color: Colors.orange.shade800)),
                      )
                          : Text('Resend OTP in $resendTime sec', style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ),




              ],
            ),
          ),
              ),
        ),),
      );
  }
}