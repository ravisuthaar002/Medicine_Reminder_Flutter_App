
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:pinput/pinput.dart';

import '../../../res/colors/app_colors.dart';
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
  void initState() {
    super.initState();
    otpVerifyViewModel.startTimer(); // start countdown here
  }


  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: AppColors.black87, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.orange800),
      borderRadius: BorderRadius.circular(14),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.black12,
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
                  Text('OTP Verification',style: TextStyle(fontSize: AppFontSize.large,fontWeight: FontWeight.w900),),

                  SizedBox(height: Get.height * .02,),
                  Text('Enter the verification code we just sent on your phone number: +91 ${widget.phone}  ',style: TextStyle(fontSize: AppFontSize.small),),
                  SizedBox(height: Get.height * .05,),
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
                  SizedBox(height: Get.height * .05,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange800,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8)
                      ),
                      onPressed: (){
                        otpVerifyViewModel.verifyOtp();
                      },

                      child: Obx(() => otpVerifyViewModel.loading.value ?
                       CircularProgressIndicator(color: AppColors.white,) :
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Verify',style: TextStyle(color: AppColors.white,fontSize: AppFontSize.medium),),
                          Icon(Icons.arrow_forward,color: AppColors.white,size: 25,)
                        ],
                      ) )),

                  SizedBox(height: Get.height * .03,),

                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(()=>
                         otpVerifyViewModel.isResendEnabled.value
                            ? TextButton(
                          onPressed: otpVerifyViewModel.resendOTP,
                          child: Text('Resend OTP', style: TextStyle(color: AppColors.orange800)),
                        )
                            : Text('Resend OTP in ${otpVerifyViewModel.resendTime.value} sec', style: TextStyle(color: AppColors.black54)),
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