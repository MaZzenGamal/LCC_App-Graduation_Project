import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'chat_patient_screen.dart';
///////////// patient is login doctors that patient reserve with them
class ChatDetailsDoctorScreen extends StatelessWidget {
  const ChatDetailsDoctorScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
          future:AppCubit.get(context).getUsers(),
          builder: (context,_) {
            return BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Chat'),
                  ),
                  body: BuildCondition(
                        condition: AppCubit.get(context).doctorsChat.isNotEmpty,
                        builder:(context)=>ListView.separated(
                            itemBuilder: (context, index) => buildChatItem(AppCubit.get(context).doctorsChat.elementAt(index),context),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: AppCubit.get(context).doctorsChat.length) ,
                        fallback: (context)=> Center(child:RichText(
                          text:const TextSpan(
                            style: TextStyle(color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(text: '"You don\'t have doctors to text, yet"\n\n',style:TextStyle(fontWeight: FontWeight.bold,fontSize:18.0 )),
                              TextSpan(text: 'To communicate with doctors :\n',style:TextStyle(fontWeight: FontWeight.bold,fontSize:15.0 )),
                              TextSpan(text: '1- You must book an appointment first\n',),
                              TextSpan(text: '2- Wait for your reservation time\n',),
                            ]
                          ) ,
                        )
                        ) ,
                      )
                );
              },
            );
          }
        );
      }
}
Widget buildChatItem(DoctorModel model,context) => InkWell(
  onTap: ()
  {
    navigateTo(context, ChatPatientScreen(docModel: model));
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