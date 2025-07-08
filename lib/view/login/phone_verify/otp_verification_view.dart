
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../../../view_modal/controller/login/otp_verification_view_modal.dart';


class OtpVerificationView extends StatefulWidget{
  final String verificationid, name, dob, phone, gender;

  const OtpVerificationView({
    super.key,
    required this.verificationid,
    required this.name,
    required this.dob,
    required this.phone,
    required this.gender,
  });


  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {

  final otpVerifyViewModel = Get.put(OtpVerificationViewModal());


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
    return Scaffold(
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
                      controller: otpVerifyViewModel.otpController,
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
                        otpVerifyViewModel.verifyOtp();
                      },

                      child: Obx(() => otpVerifyViewModel.loading.value ?
                       CircularProgressIndicator() :
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Verify',style: TextStyle(color: Colors.white,fontSize: 18),),
                          Icon(Icons.arrow_forward,color: Colors.white,size: 25,)
                        ],
                      ) )),

                  Container(height: 20,),

                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(()=>
                         otpVerifyViewModel.isResendEnabled.value
                            ? TextButton(
                          onPressed: otpVerifyViewModel.resendOTP,
                          child: Text('Resend OTP', style: TextStyle(color: Colors.orange.shade800)),
                        )
                            : Obx(()=> Text('Resend OTP in ${otpVerifyViewModel.resendTime} sec', style: TextStyle(color: Colors.black45))),
                        )],
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