import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/app_layout.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/modules/login/cubit/login_cubit.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../login/cubit/states.dart';

class LoginIndicatorScreen extends StatelessWidget {
  const LoginIndicatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){
        // if(state is AppInitialState){
        //   navigateAndFinish(context, AppLayout());
        // }
      },
      builder:(context,state){
        return Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator(
            color: Colors.grey[300],
            backgroundColor: Colors.grey,
          )),
        );
      } ,
    );
  }
}
