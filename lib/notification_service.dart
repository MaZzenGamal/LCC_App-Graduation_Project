import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'models/navkey.dart';
final navigatorKey=NavKey.navkey;
Future<FirebaseApp> fireInit() async {
//Firebase Messaging instance
  final fireApp = await Firebase.initializeApp();
  FirebaseMessaging.instance;

// Flutter local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

//Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

//Background Notifications
 /* FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

  //App is a sleep
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _handleMessage(initialMessage);
    navigatorKey.currentState!.pushNamed('profile');
  }
  //App is dormant
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

  //Foreground
  FirebaseMessaging.onMessage.listen(onMessageHandler);*/

  return fireApp;
}

//Message Handler
/*void _handleMessage(RemoteMessage message) {
  if (kDebugMode) {
    print("Handling a foreground message: ${message.data}");
    navigatorKey.currentState!.pushNamed('profile');
  }
}*/

/*Future<void> backgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.data}");
  }
}*/

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('A Background message just showed up :  ${message.messageId}');
  }
}*/

/*void onMessageHandler(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            playSound: true,
            icon: 'app_icon',
          ),
        ));
    navigatorKey.currentState!.pushNamed('profile');
  }
}*/


// void _forgroundHandleMessage(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;

//   if (notification != null && android != null) {
//     localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//           ),
//         ));
//   }

//   print("Handling a foreground message: ${message.data}");
// }


