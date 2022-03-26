import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/conestants.dart';

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
      listener:(context,state){} ,
      builder: (context,state){
        return  Column(
          children: [
            Center(
              child: defaultTextButton(
                  function: (){
                    AppCubit.get(context).signOut();
                    navigateAndFinish(context, LoginScreen());
                  },
                  text: 'sign out'),
            )
          ],
        );
      },
    );
  }
}
