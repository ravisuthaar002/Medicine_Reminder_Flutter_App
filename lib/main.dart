import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/notification_services.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes.dart';
import 'package:medicine_reminder_flutter_app/view/splash_screen.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/login/login_view_modal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationServices.initialize();

  Get.put(LoginViewModal());

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        getPages: AppRoutes.appRoutes()
    );
  }
}
