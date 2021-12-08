import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/cubit/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/cubit/states.dart';
import 'package:graduation_project/layouts/patient_layout/patient_cubit.dart';
import 'package:graduation_project/shared/block_observer.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/styles/themes.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  //DioHelper.init();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()),
        BlocProvider(create: (context)=>PatientCubit())
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)=>MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          //darkTheme: darkTheme,
          home: const OnBoardingScreen(),
        ),
      )
    );
  }
}
