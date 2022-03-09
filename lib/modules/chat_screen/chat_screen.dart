import 'package:conditional_builder/conditional_builder.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../shared/network/local/cash_helper.dart';
import '../../shared/network/local/cash_helper.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  var type1=CacheHelper.getData(key: 'type');
  var list;
  @override
  Widget build(BuildContext context) {
    if(type1=='patient') {
      list='doctors';
    };
    if(type1=='doctor'){
      list='patients';
    };
    print(type1);

      return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
          ),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).doctors.length > 0,
            builder: (context)=>ListView.separated(
                itemBuilder: (context, index) => buildChatItem(AppCubit.get(context).doctors[index],context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: AppCubit.get(context).doctors.length),
            //fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
          ),
        );
      },
    );
    }
  }


Widget buildChatItem(DoctorModel model,context) => InkWell(
  onTap: ()
  {
    navigateTo(context, ChatDetailsScreen(docModel: model,));
  } ,
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
            '${model.image}',
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${model.fullName}',
                      style: TextStyle(fontSize: 18.0, height: 1.3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
