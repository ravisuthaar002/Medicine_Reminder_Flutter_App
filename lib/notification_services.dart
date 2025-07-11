// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// Future<void> BackgroundHandler(RemoteMessage remoteMessage) async {
//   log("Background Title: ${remoteMessage.notification?.title}");
// }
//
// class NotificationServices {
//   static Future<void> initialize() async {
//     NotificationSettings notificationSettings = await FirebaseMessaging.instance.requestPermission();
//
//     if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
//       FirebaseMessaging.onBackgroundMessage(BackgroundHandler);
//
//       FirebaseMessaging.onMessage.listen((message) {
//         log("Foreground Title: ${message.notification?.title}");
//       });
//
//       log("Message Authorized");
//     } else {
//       log("Notification permission not granted");
//     }
//   }
// }
