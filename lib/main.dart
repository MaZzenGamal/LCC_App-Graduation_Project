//@dart=2.9
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_layout.dart';
import 'package:graduation_project/modules/cancer%20_informations/cancer_info_screen.dart';
import 'package:graduation_project/modules/cancer%20_informations/motivation_screen.dart';
import 'package:graduation_project/modules/language/languages_screen.dart';
import 'package:graduation_project/modules/login/cubit/login_cubit.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/profile_screen/profile_screen.dart';
import 'package:graduation_project/modules/register/register_screen2.dart';
import 'package:graduation_project/modules/syndromes/syndromes_screen.dart';
import 'package:graduation_project/shared/block_observer.dart';
import 'package:graduation_project/shared/components/conestants.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/styles/themes.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'layouts/app_layout/app_cubit.dart';
import 'layouts/app_layout/states.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/register/cubit/register_cubit.dart';
import 'modules/register/register_screen1.dart';
import 'modules/register/register_screen3.dart';
import 'myTest/test_screen.dart';
Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  print("on background message");
  print(message.data.toString());

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  OneSignal.shared.setAppId('ecd11fed-ac58-43f7-b224-1d158bf5dfdd');
  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Will be called whenever a notification is opened/button pressed.
  });
  await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
  var token= await FirebaseMessaging.instance.getToken();
  print (token);
  //foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print (event.data.toString());
  });
  //when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print (event.data.toString());
  });
  //background fcm    fcm  firebase cloud messaging
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  //DioHelper.init();
  await CacheHelper.init();
  
  uId = CacheHelper.getData(key: 'uId');
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const MyApp({Key? key}) : super(key: key);
  @override
  voidninitState(){
    super.initState();
    configOneSignal();
  }
  void configOneSignal(){
    OneSignal.shared.setAppId('ecd11fed-ac58-43f7-b224-1d158bf5dfdd');
  }
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..getUsers()..getDoctorData()),
        BlocProvider(create: (context)=>RegisterCubit(),)
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)=>MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          //darkTheme: darkTheme,
          home:LoginScreen(),
        ),
      )
    );
  }
}
