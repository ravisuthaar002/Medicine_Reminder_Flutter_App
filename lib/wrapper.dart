import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_flutter_app/home_page.dart';
import 'package:medicine_reminder_flutter_app/personal_data_page.dart';
import 'package:medicine_reminder_flutter_app/verify_email.dart';

import 'login_page.dart';

class Wrapper extends StatefulWidget{
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
         body: StreamBuilder(
             stream: FirebaseAuth.instance.authStateChanges(),
             builder: (context,snapshot){
               if(snapshot.hasData){
                   if (snapshot.data!.phoneNumber != null) {
                     return HomePage();
                   }else{
                     return Personal_Data_Page();
                   }
               }else{
                 return Login_page();
               }
             }
         ),
     );
  }
}