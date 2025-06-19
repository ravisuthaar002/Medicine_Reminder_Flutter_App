import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_flutter_app/signup_page.dart';
import 'package:medicine_reminder_flutter_app/wrapper.dart';

class ThreeLine_Menu_Page extends StatefulWidget{
  @override
  State<ThreeLine_Menu_Page> createState() => _ThreeLine_Menu_PageState();
}

class _ThreeLine_Menu_PageState extends State<ThreeLine_Menu_Page> {
  signout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Wrapper()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white,size: 24),
        backgroundColor: Colors.orange.shade800,
        title: Text('Settings & activity',style: TextStyle(color: Colors.white,fontSize: 24),),
        centerTitle: true,
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your account',style: TextStyle(fontSize: 18,color: Colors.grey.shade700,fontWeight: FontWeight.bold),),
            TextButton(onPressed: (){}, child: Row(
              children: [
                Icon(Icons.account_circle_outlined,color: Colors.grey.shade800,size: 25,),
                 SizedBox(width: 10,),
                 Text('Account Centre',style: TextStyle(fontSize: 18,color: Colors.grey.shade800),),
              ],
            ),),
            SizedBox(height: 20,),
            Text('Login',style: TextStyle(fontSize: 18,color: Colors.grey.shade700,fontWeight: FontWeight.bold),),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_page()));
                },
                child: Text('Add account',style: TextStyle(fontSize: 18,color: Colors.blue),)),
            TextButton(onPressed: ()=>signout(), child: Text('Log out',style: TextStyle(fontSize: 18,color: Colors.red),)),
          ],
        ),
      ),
    );
  }
}