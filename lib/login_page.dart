// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:medicine_reminder_flutter_app/forgot.dart';
// import 'package:medicine_reminder_flutter_app/signup_page.dart';
// import 'package:medicine_reminder_flutter_app/view_modal/controller/login/wrapper_view_modal.dart';
//
// class Login_page extends StatefulWidget{
//   @override
//   State<Login_page> createState() => _Login_pageState();
// }
//
// class _Login_pageState extends State<Login_page> {
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   bool hidePassword = true;
//
//   bool isloading = false;
//
//   signIn()async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     final GoogleSignInAuthentication? googleAuth = await googleUser
//         ?.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//     await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//
//
//
//   logIn() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       isloading = true;
//     });
//
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       Get.offAll(Wrapper());
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = "";
//
//       switch (e.code) {
//         case 'user-not-found':
//           errorMessage = "No user found for that email.";
//           break;
//         case 'wrong-password':
//           errorMessage = "Incorrect password. Please try again.";
//           break;
//         case 'invalid-email':
//           errorMessage = "The email address is not valid.";
//           break;
//         default:
//           errorMessage = "Login failed. ${e.message}";
//       }
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMessage),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("An error occurred. Please try again."),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//
//     setState(() {
//       isloading = false;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return isloading?Center(child: CircularProgressIndicator(),) : Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 70),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Login to your account.',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
//                 Text('Please sign in to your account',style: TextStyle(fontSize: 14,color: Colors.black54),),
//                 SizedBox(height: 30),
//                 Align(alignment: Alignment.center, child: Text("Welcome Back 👋", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
//                 SizedBox(height: 50),
//
//                 Text('Email Address',style: TextStyle(fontSize: 14),),
//                 SizedBox(height: 10,),
//                 TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                           BorderSide(width: 2, color: Colors.orange.shade800)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(width: 2, color: Colors.grey))
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'Please enter email';
//                     else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
//                       return 'Enter valid email';
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 30),
//
//                 Text('Password',style: TextStyle(fontSize: 14),),
//                 SizedBox(height: 10,),
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: hidePassword,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                           BorderSide(width: 2, color: Colors.orange.shade800)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(width: 2, color: Colors.grey)),
//                     suffixIcon: IconButton(
//                       icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
//                       onPressed: () {
//                         setState(() {
//                           hidePassword = !hidePassword;
//                         });
//                       },
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'Please enter password';
//                     else if (value.length < 6)
//                       return 'Password must be at least 6 characters';
//                     return null;
//                   },
//                 ),
//                 TextButton(onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Forgot()));
//                 } , child: Text('Forgot password?',style: TextStyle(fontSize: 14,color: Colors.orange.shade800),)),
//                 SizedBox(height: 50),
//
//                 // Submit Button
//                 Center(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange.shade800,
//                         padding: EdgeInsets.symmetric(vertical: 8,horizontal: 40)),
//                     onPressed: () {
//                       logIn();
//                       if (_formKey.currentState!.validate()) {
//                         // ScaffoldMessenger.of(context).showSnackBar(
//                         //   SnackBar(content: Text("Logging in...")),
//                         // );
//                       }
//                     },
//                     child: Text("Log In",style: TextStyle(fontSize: 20,color: Colors.white)),
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//
//                 Center(
//                   child: TextButton(
//                       onPressed: (()=>signIn()),
//                       child: Text('Sign In with Google',style: TextStyle(fontSize: 16,color: Colors.orange.shade800),)),
//                 ),
//
//                 SizedBox(height: 20,),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Don`t have an account?',style: TextStyle(fontSize: 14),),
//                     TextButton(onPressed: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_page()));
//                     }, child: Text('Register',style: TextStyle(fontSize: 14,color: Colors.orange.shade800),))
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }