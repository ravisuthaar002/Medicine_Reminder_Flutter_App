import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Wait until the auth state is known
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Navigate AFTER the current frame
          Future.microtask(() {
            if (snapshot.hasData) {
              if (snapshot.data!.phoneNumber != null) {
                Get.offAllNamed(RoutesName.homePage);
              } else {
                Get.offAllNamed(RoutesName.personalData);
              }
            } else {
              Get.offAllNamed(RoutesName.loginView);
            }
          });

          // While navigating, return a loading widget
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
