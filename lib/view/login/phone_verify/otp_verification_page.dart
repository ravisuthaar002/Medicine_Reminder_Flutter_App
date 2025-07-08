import 'package:flutter/material.dart';
import 'package:medicine_reminder_flutter_app/view/login/phone_verify/otp_verification_view.dart';

class OtpVerificationPage extends StatelessWidget {
  final String verificationid;
  final String name;
  final String dob;
  final String phone;
  final String gender;

  const OtpVerificationPage({
    super.key,
    required this.verificationid,
    required this.name,
    required this.dob,
    required this.phone,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return OtpVerificationView(
      verificationid: verificationid,
      name: name,
      dob: dob,
      phone: phone,
      gender: gender,
    );
  }
}
