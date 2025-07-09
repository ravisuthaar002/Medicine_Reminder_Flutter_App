import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/res/colors/app_colors.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';

class ThreeLineMenuPage extends StatelessWidget{
  const ThreeLineMenuPage({super.key});

  signOut()async{
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(RoutesName.wrapper);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white,size: AppFontSize.mediumPlus),
        backgroundColor: AppColors.orange800,
        title: Text('Settings & activity',style: TextStyle(color: AppColors.white,fontSize: AppFontSize.mediumPlus),),
        centerTitle: true,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your account',style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.grey700,fontWeight: FontWeight.bold),),
            TextButton(onPressed: (){}, child: Row(
              children: [
                Icon(Icons.account_circle_outlined,color: AppColors.grey800,size: AppFontSize.mediumPlus,),
                 SizedBox(width: 10,),
                 Text('Account Centre',style: TextStyle(fontSize: AppFontSize.medium,color: Colors.grey.shade800),),
              ],
            ),),
            SizedBox(height: Get.height * .02,),
            Text('Login',style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.grey700,fontWeight: FontWeight.bold),),
            TextButton(onPressed: (){
              Get.offAllNamed(RoutesName.signupView);
                },
                child: Text('Add account',style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.blue),)),
            TextButton(onPressed: ()=>signOut(), child: Text('Log out',style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.red),)),
          ],
        ),
      ),
    );
  }
}