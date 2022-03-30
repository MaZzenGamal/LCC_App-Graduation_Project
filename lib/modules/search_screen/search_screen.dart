import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/conestants.dart';
import 'package:restart_app/restart_app.dart';

import '../../myTest/restart_screen.dart';
import '../../shared/network/local/cash_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
bool isStrechedDropDown = false;
class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){
        if(state is SignOutLoadingState){
          CacheHelper.removeDate(key: 'uId',);
          navigateAndFinish(context, LoginScreen());
        }
      } ,
      builder: (context,state){
        return  Column(
          children: [
            Center(
              child: defaultTextButton(
                  function: (){
                    RestartWidget.restartApp(context);
                  },
                  text: 'sign out'),
            )
          ],
        );
      },
    );
  }
}
