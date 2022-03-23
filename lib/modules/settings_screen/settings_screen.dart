import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cancer%20_informations/cancer_info_screen.dart';
import 'package:graduation_project/modules/language/languages_screen.dart';
import 'package:graduation_project/modules/profile_screen/profile_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../layouts/app_layout/app_cubit.dart';
import '../../layouts/app_layout/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
    listener: (context, state) {} ,
    builder: (context,state){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          physics:BouncingScrollPhysics() ,
          itemBuilder: (context,index)=>InkWell(
            child: Container(
              height: 80.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Profile',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            onTap: (){
             // AppCubit.get(context).getUsers();
              navigateTo(context, ProfileScreen());
            },
          ),
          separatorBuilder: (context,index)=>myDivider(),
          itemCount: 1),
      );
    });
  }
}
