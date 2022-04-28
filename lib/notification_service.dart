import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:graduation_project/modules/chat_screen/chat_details_screen_doctor.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/modules/chat_screen/chat_details_screen.dart';
import 'models/navkey.dart';
var type = CacheHelper.getData(key: 'type');
PatientModel patModel=PatientModel();
DoctorModel docModel=DoctorModel();

Future<FirebaseApp> fireInit(BuildContext context) async {
//Firebase Messaging instance
  final fireApp = await Firebase.initializeApp();
  FirebaseMessaging.instance;
  return fireApp;
}

Future<void>fcmInit(GlobalKey<NavigatorState> navkey)async{

// Flutter local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /*await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
    android: initializationSettingsAndroid,), onSelectNotification: _onClick(navkey: navkey, message: message),
  );*/

//Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

//Background Notifications
  FirebaseMessaging.onBackgroundMessage((message) => _firebaseMessagingBackgroundHandler(message, navkey));

  //App is a sleep
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _firebaseMessagingBackgroundHandler(initialMessage, navkey);
  }
  //App is dormant
  FirebaseMessaging.onMessageOpenedApp.listen((message)=>_firebaseMessagingBackgroundHandler(message,navkey));

  //Foreground
  FirebaseMessaging.onMessage.listen( (message) => onMessageHandler(message, navkey));

}

//Message Handler
void _handleMessage(RemoteMessage message, GlobalKey<NavigatorState> navkey) {
  if (kDebugMode) {
    print("Handling a foreground message: ${message.data}");
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.data}");
  }
}

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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message, GlobalKey<NavigatorState> navkey ) async {
  _onClick(message: message, navkey: navkey);
}

void onMessageHandler(RemoteMessage message,GlobalKey<NavigatorState> navkey) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    if (kDebugMode) {
      print(notification);
    }
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
            icon: '@mipmap/ic_launcher',
          ),
        ));
  }
}

Future<void> _onClick({
  required RemoteMessage message,
  required GlobalKey<NavigatorState> navkey,
}) async {
  var navigate=message.data['uidsender'];
  print("the $navigate");
  if(type=='patient'){
    FirebaseFirestore.instance.collection('doctor').doc(navigate).snapshots()
        .listen((event) {
      docModel = DoctorModel.fromJson(event.data()!);
    });
    navkey.currentState!.pushNamed('chatpatient',arguments:docModel);
  }
  else{
    FirebaseFirestore.instance.collection('patient').doc(navigate).snapshots()
        .listen((event) {
      patModel = PatientModel.fromJson(event.data()!);
    });
    navkey.currentState!.pushNamed('chatdoctor',arguments:patModel);
  }
}

const AndroidInitializationSettings initializationSettingsAndroid =
AndroidInitializationSettings('app_icon');
////////ChatDetailsScreenDoctor  patientModel
///////////ChatDetailsScreen doctor model

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


