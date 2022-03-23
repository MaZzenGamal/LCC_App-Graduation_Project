//ignore_for_file: must_be_immutable
import 'dart:convert';

import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:http/http.dart';

import '../../shared/network/local/cash_helper.dart';
class ChatDetailsScreen extends StatelessWidget {
  PatientModel? patModel;
  DoctorModel? docModel;
  int? index;

//ChatDetailsScreen({Key? key, patModel, docModel}) : super(key: key);

  ChatDetailsScreen({Key? key, this.docModel,this.index}) : super(key: key);

  var messageController = TextEditingController();

  Future<Response> sendNotification(String token, String contents, String heading) async {
    print("xxxxx");
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": 'ecd11fed-ac58-43f7-b224-1d158bf5dfdd',//kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids": token,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color":"FF9976D2",

        "small_icon":"ic_stat_onesignal_default",

        "large_icon":"https://www.filepicker.io/api/file/zPloHSmnQsix82nlj9Aj?filename=name.jpg",

        "headings": {"en": heading},

        "contents": {"en": contents},

      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          AppCubit.get(context).getMessage(receiverId: docModel!.uId!);
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
                            '${docModel!.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${docModel!.fullName}',
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
                                  )
                              ),
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
                                  if(AppCubit.get(context).doctors[0]!=docModel!) {
                                    AppCubit.get(context).removeDoctor(index!);
                                    AppCubit.get(context).replaceDoctor(docModel!);
                                    docModel!.createdAt!=Timestamp.now();
                                  }
                                  print("id of user to send him ${docModel!.uId!}");
                                  var y=CacheHelper.getData(key: 'uId');
                                  print('sender id when logging ${y}');
                                  AppCubit.get(context).sendMessage(
                                      receiverId: docModel!.uId!,
                                      dateTime: DateTime.now()
                                          .toString(),
                                      text: messageController.text);
                                  sendNotification('${docModel!.token!}', "nada", "hello");
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


//ignore_for_file: must_be_immutable
/*import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';

class ChatDetailsScreen extends StatelessWidget {*/
//ChatDetailsScreen({Key? key}) : super(key: key);

// PatientModel? patModel;
// DoctorModel? docModel;

//ChatDetailsScreen({Key? key, patModel, docModel}) : super(key: key);

/*ChatDetailsScreen({Key? key, this.docModel}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          AppCubit.get(context).getMessage(receiverId: docModel!.uId!);
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
                            '${docModel!.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${docModel!.fullName}',
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
                                  AppCubit.get(context).sendMessage(
                                      receiverId: docModel!.uId!,
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
);*/


