//@dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/navkey.dart';
import 'package:graduation_project/modules/login/cubit/login_cubit.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/reservation_screen/doctor_information_screen.dart';
import 'package:graduation_project/modules/reservation_screen/doctors.dart';
import 'package:graduation_project/modules/search_screen/search_screen.dart';
import 'package:graduation_project/shared/block_observer.dart';
import 'package:graduation_project/shared/components/conestants.dart';
import 'package:graduation_project/shared/cubit/main_cubit.dart';
import 'package:graduation_project/shared/cubit/main_states.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/styles/themes.dart';
import 'layouts/app_layout/app_cubit.dart';
import 'modules/register/cubit/register_cubit.dart';
import 'myTest/restart_screen.dart';
import 'notification_service.dart';
Future<void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  //DioHelper.init();
  await CacheHelper.init();
  // token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');
  // Widget widget;

  // if(uId != null)
  // {
  //   widget = AppLayout();
  // }else
  // {
  //   widget = LoginScreen();
  // }
  runApp(
    RestartWidget(
      child:const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>MainCubit(),),
        BlocProvider(create: (context)=>AppCubit()..getUsers()..getUserData()),
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>RegisterCubit(),),
      ],
      child: FutureBuilder(
          future: fireInit(),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      return BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) =>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              //darkTheme: darkTheme,
              navigatorKey: NavKey?.navkey,
              routes:{
                'profile':(context)=> SearchScreen(),

              },
              home:LoginScreen(),//DoctorsScreen(),//LoginScreen(), //LoginPage(),//LoginScreen(),//HomeTestScreen()//LoginScreen(),
            ),
      );
    })
    );

  }
}
