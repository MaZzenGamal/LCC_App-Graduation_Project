// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:buildcondition/buildcondition.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../models/doctor_model.dart';
import 'chat_details_screen_doctor.dart';

class ChatScreenDoctor extends StatelessWidget {
  const ChatScreenDoctor({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {              //patient is logining
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: BuildCondition(
            condition: AppCubit.get(context).doctors.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildChatItem(AppCubit.get(context).doctors[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: AppCubit.get(context).doctors.length),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
Widget buildChatItem(DoctorModel model,context) => InkWell(
  onTap: ()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreenDoctor(docModel: model,),));
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
                      style: const TextStyle(fontSize: 18.0, height: 1.3),
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