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
import 'package:graduation_project/modules/register/register_screen2.dart';
import 'package:graduation_project/modules/syndromes/syndromes_screen.dart';
import 'package:graduation_project/shared/block_observer.dart';
import 'package:graduation_project/shared/components/conestants.dart';
import 'package:graduation_project/shared/cubit/main_cubit.dart';
import 'package:graduation_project/shared/cubit/main_states.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/styles/themes.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'layouts/app_layout/app_cubit.dart';
import 'layouts/app_layout/states.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/register/cubit/register_cubit.dart';
import 'modules/register/register_screen1.dart';
import 'modules/register/register_screen3.dart';
import 'modules/reservation_screen/doctors.dart';
import 'myTest/restart_screen.dart';
import 'myTest/test_screen.dart';
void main() async {
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
      child:MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const MyApp({Key? key}) : super(key: key);
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>MainCubit(),),
        BlocProvider(create: (context)=>AppCubit()..getUsers()..getUserData()..getComment(uId)),
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>RegisterCubit(),),
      ],
      child: BlocConsumer<MainCubit,MainStates>(
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
