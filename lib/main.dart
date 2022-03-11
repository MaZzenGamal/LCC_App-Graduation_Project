//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/block_observer.dart';
import 'package:graduation_project/shared/components/conestants.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/styles/themes.dart';
import 'layouts/app_layout/app_cubit.dart';
import 'layouts/app_layout/patient_layout.dart';
import 'layouts/app_layout/states.dart';
import 'modules/register/cubit/register_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  //DioHelper.init();
  await CacheHelper.init();
  
  uId = CacheHelper.getData(key: 'uId');
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..getUsers()),
        BlocProvider(create: (context)=>RegisterCubit(),)
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)=>MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          //darkTheme: darkTheme,
          home: LoginScreen(),
          routes: <String, WidgetBuilder> {
            'AppLayout': (BuildContext context) => const AppLayout(),
            'login':(BuildContext context) => LoginScreen(),
          },

          // '/screen1': (BuildContext context) => new Screen1(),
        ),
      )
    );
  }
}
