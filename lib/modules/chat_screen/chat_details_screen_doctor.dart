//ignore_for_file: must_be_immutable
import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';

class ChatDetailsScreenDoctor extends StatelessWidget {
  //ChatDetailsScreen({Key? key}) : super(key: key);

  PatientModel? patModel;
  DoctorModel? docModel;
  int?index;
  //ChatDetailsScreen({Key? key, patModel, docModel}) : super(key: key);

  ChatDetailsScreenDoctor({Key? key, this.patModel,this.index}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          AppCubit.get(context).getMessage(receiverId: patModel!.uId!);
          return BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    titleSpacing: 0.0,
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                            '${patModel!.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${patModel!.fullName}',
                          style: const TextStyle(
                              fontSize: 15.0
                          ),
                        )
                      ],
                    ),
                    actions: [
                      IconButton(onPressed: () {},
                          icon: const Icon(
                              Icons.call
                          )),
                      IconButton(onPressed: () {},
                          icon: const Icon(
                              Icons.video_call
                          )),
                    ],
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: BuildCondition(
                          condition: AppCubit.get(context).messages.isNotEmpty,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var message = AppCubit.get(context).messages[index];
                                  if (AppCubit.get(context).uID == message.senderId) {
                                    return buildMyMessages(message);
                                  }
                                  return buildMessages(message);
                                },
                                separatorBuilder: (context, index) => const SizedBox(height: 15.0,),
                                itemCount: AppCubit.get(context).messages.length),
                          ),
                          fallback: (context) =>const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              IconButton(onPressed: () {},
                                  icon: const Icon(
                                      Icons.add_circle
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      horizontal: 10.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'write your message...'
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                if (messageController.text != '') {
                                  if(AppCubit.get(context).patients[0]!=patModel!){
                                    AppCubit.get(context).removePatient(index!);
                                    AppCubit.get(context).replacePatient(patModel!);
                                   patModel!.createdAt!=Timestamp.now();
                                  }
                                    AppCubit.get(context).sendMessage(
                                      receiverId: patModel!.uId!,
                                      dateTime: DateTime.now()
                                          .toString(),
                                      text: messageController.text);
                                }
                                messageController.text = '';
                              },
                                  icon: const Icon(
                                      Icons.send
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        }
    );
  }
}

Widget buildMessages(MessagesModel model) =>Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          bottomEnd: Radius.circular(10.0),
        )
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0),
      child: Text(
          '${model.text}'),
    ),
  ),
);
Widget buildMyMessages(MessagesModel model) =>Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          bottomStart: Radius.circular(10.0),
        )
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0),
      child: Text(
          '${model.text}'),
    ),
  ),
);
