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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
