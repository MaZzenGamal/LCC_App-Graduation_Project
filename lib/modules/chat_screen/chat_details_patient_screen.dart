import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../models/messages_model.dart';
import '../../models/patient_model.dart';
import '../../shared/network/local/cash_helper.dart';
import 'chat_doctor_screen.dart';
import 'package:intl/intl.dart';
///////////// doctor is login patients that doctor reserve with them
class ChatDetailsPatientScreen extends StatelessWidget {
  const ChatDetailsPatientScreen({Key? key}) : super(key: key);

  //var type1=CacheHelper.getData(key: 'type');
  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: 'type'));
        return FutureBuilder(
          future:  AppCubit.get(context).getUsers(),
          builder: (context,_) {
            return BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {
              },
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Chat'),
                  ),
                  body:BuildCondition(
                      condition:AppCubit.get(context).patients.isNotEmpty ,
                      builder:(context)=> ListView.separated(
                          itemBuilder: (context, index) => buildChatItem(AppCubit.get(context).patients.elementAt(index),context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: AppCubit.get(context).patients.length),
                      fallback:(context)=> Center(child:RichText(
                        text:const TextSpan(
                            style: TextStyle(color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(text: '"You don\'t have patients to text, yet"\n\n',style:TextStyle(fontWeight: FontWeight.bold,fontSize:18.0 )),
                              TextSpan(text: 'To communicate with patients :\n',style:TextStyle(fontWeight: FontWeight.bold,fontSize:15.0 )),
                              TextSpan(text: '1- They must book an appointment first\n',),
                              TextSpan(text: '2- Wait for their reservation time\n',),
                            ]
                        ) ,
                      )
                      ) ,
                    ),
                );
              },
            );
          }
        );
      }
}


Widget buildChatItem(PatientModel model,context) => FutureBuilder(
    future: AppCubit.get(context).getLastMessage(model.uId!),
    builder: (BuildContext context, AsyncSnapshot<MessagesModel> snapshot) {
      if(snapshot.data==null){
        if (kDebugMode) {
          print("gggggggggggggggggg");
        }
        return const LinearProgressIndicator();
      }else {
        return InkWell(

          onTap: () {
            navigateTo(context, ChatDoctorScreen(patModel: model));
          },

          child: Padding(

            padding: const EdgeInsets.all(20.0),

            child: Row(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                CircleAvatar(

                  radius: 35.0,

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

                        Column(

                          children: [
                            Row(
                              children: [
                                Text(

                                  '${model.fullName}',
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      height: 1.3,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),

                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DateFormat('EEEE, MMM d, yyyy').format(AppCubit.get(context).messModel.dateTime!) ==
                                    DateFormat('EEEE, MMM d, yyyy').format(DateTime.now())&&AppCubit.get(context).messModel.text!='empty'?Text(
                                    DateFormat('HH:mm').format(AppCubit.get(context).messModel.dateTime!)):DateFormat('EEEE, MMM d, yyyy').format(AppCubit.get(context).messModel.dateTime!) ==
                                    DateFormat('EEEE, MMM d, yyyy').format(DateTime.now())&&AppCubit.get(context).messModel.text=='empty'?Container():Text(
                                    DateFormat('MMM d, yyyy').format(AppCubit.get(context).messModel.dateTime!)),
                              ],
                            ),
                            AppCubit.get(context).messModel.text=='empty'?Container():
                            AppCubit.get(context).messModel.type=='text'?
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${AppCubit.get(context).messModel.text}',maxLines:2 ,)
                            )
                                :Row(
                              children: const [
                                Icon(Icons.photo),
                                SizedBox(width: 10),
                                Text('photo')
                              ],
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
      }
    }
);
