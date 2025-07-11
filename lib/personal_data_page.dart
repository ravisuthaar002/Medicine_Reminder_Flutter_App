//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:medicine_reminder_flutter_app/otp_phone_verification_page.dart';
//
// class Personal_Data_Page extends StatefulWidget {
//   const Personal_Data_Page({super.key});
//
//   @override
//   State<Personal_Data_Page> createState() => _Personal_Data_PageState();
// }
//
// class _Personal_Data_PageState extends State<Personal_Data_Page> {
//   final _formKey = GlobalKey<FormState>();
//
//   String? _validatePhoneNmber(value) {
//     value.isEmpty ? 'Please enter enter a phone number' : null;
//     if (value.length != 10) {
//       return 'Please enter a 10-digit phone number';
//     }
//     return null;
//   }
//
//   final nameController = TextEditingController();
//   final dobController = TextEditingController();
//   final phoneController = TextEditingController();
//
//   String? selectedGender = 'Male';
//   List<String> genderList = ['Male', 'Female', 'Other'];
//
//   bool isloading = false;
//
//   send()async{
//     setState(() {
//       isloading = true;
//     });
//     if (_formKey.currentState!.validate()) {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//           verificationCompleted:
//               (PhoneAuthCredential credential) {print("Verification completed");},
//           verificationFailed: (FirebaseAuthException ex) {print("Verification failed: ${ex.message}");},
//           codeSent: (String verificationid, int? resendtoken) {
//             print("OTP sent. Verification ID: ${verificationid}");
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>Otp_Verification_Page(verificationid: verificationid, name: nameController.text.toString(), dob: dobController.text.toString(), phone: phoneController.text.toString(), gender: selectedGender.toString(),)));
//           },
//           codeAutoRetrievalTimeout: (String verificationId) {},
//           phoneNumber: '+91${phoneController.text.toString()}'
//       );
//       if (_formKey.currentState!.validate()) {
//         print("not work");
//       }
//     }
//     setState(() {
//       isloading = false;
//     });
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return isloading?Center(child: CircularProgressIndicator(),) : Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(size: 22,color: Colors.white),
//         title: Text(
//           'Personal Detail',
//           style: TextStyle(fontSize: 22, color: Colors.white),
//         ),
//         backgroundColor: Colors.orange.shade800,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '  Full Name',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: nameController,
//                   style: TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     hintText: 'Ravi...',
//                     hintStyle: TextStyle(fontSize: 18,color: Colors.black26),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: Colors.orange.shade800,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(width: 2, color: Colors.grey),
//                     ),
//                   ),
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Please enter name'
//                       : null,
//                 ),
//                 SizedBox(height: 30),
//
//                 Text(
//                   '  Phone Number',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: phoneController,
//                   keyboardType: TextInputType.number,
//                   style: TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     hintText: '9998887776',
//                     hintStyle: TextStyle(fontSize: 18,color: Colors.black26),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: Colors.orange.shade800,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(width: 2, color: Colors.grey),
//                     ),
//                   ),
//                   validator: _validatePhoneNmber,
//                 ),
//                 SizedBox(height: 30),
//
//                 Text(
//                   '  Gender',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 DropdownButtonFormField<String>(
//                   value: selectedGender,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 8,
//                     ),
//                     // labelText: 'Gender',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: Colors.orange.shade800,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(width: 2, color: Colors.grey),
//                     ),
//                   ),
//                   // validator:
//                   icon: Icon(Icons.arrow_drop_down, size: 30),
//                   items: genderList.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value, style: TextStyle(fontSize: 18)),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     selectedGender = newValue!;
//                   },
//                   isDense: false,
//                   isExpanded: true,
//                 ),
//                 SizedBox(height: 30),
//
//                 Text(
//                   '  Date of Birth',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: dobController,
//                   style: TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     hintText: '15oct2003 / 15/10/2003',
//                     hintStyle: TextStyle(fontSize: 18,color: Colors.black26),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: Colors.orange.shade800,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(width: 2, color: Colors.grey),
//                     ),
//                   ),
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Please enter Date of Birth'
//                       : null,
//                 ),
//
//                 SizedBox(height: 45),
//
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange.shade800,
//                       padding: EdgeInsets.symmetric(vertical: 8),
//                     ),
//                     onPressed: (){
//                       send();
//                     },
//                     child: Text(
//                       'Save & Send OTP',
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
