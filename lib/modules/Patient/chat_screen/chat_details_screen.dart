// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/layouts/patient_layout/patient_cubit.dart';
// import 'package:graduation_project/layouts/patient_layout/states.dart';
// import 'package:graduation_project/models/doctor_model.dart';
// import 'package:graduation_project/models/patient_model.dart';
// import 'package:graduation_project/shared/components/components.dart';
// import 'package:graduation_project/shared/styles/icon_broken.dart';
//
// class ChatDetailsScreen extends StatelessWidget {
//    //ChatDetailsScreen({Key? key}) : super(key: key);
//
//    PatientModel? patModel;
//    DoctorModel? docModel;
//
//    ChatDetailsScreen({Key? key, this.patModel,}) : super(key: key);
//
//   var messageController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//         builder: (BuildContext context) {
//           PatientCubit.get(context).getMessage(receiverId: docModel!.uId!);
//       return BlocConsumer<PatientCubit,PatientStates>(
//         listener: (context,state){},
//         builder: (context,state){
//           return Scaffold(
//             appBar: AppBar(
//               titleSpacing: 0.0,
//               title: Row(
//                 children:const[
//                   CircleAvatar(
//                     radius: 15.0,
//                     backgroundImage: NetworkImage(
//                       '${docModel!.image}',
//                     ),
//                   ),
//                   SizedBox(
//                     width: 8.0,
//                   ),
//                   Text(
//                     'DR.Mundo',
//                     style: TextStyle(
//                         fontSize: 15.0
//                     ),
//                   )
//                 ],
//               ),
//               actions: [
//                 IconButton(onPressed: (){},
//                     icon: Icon(
//                         Icons.call
//                     )),
//                 IconButton(onPressed: (){},
//                     icon: Icon(
//                         Icons.video_call
//                     )),
//               ],
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: AlignmentDirectional.centerStart,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadiusDirectional.only(
//                             topStart: Radius.circular(10.0),
//                             topEnd: Radius.circular(10.0),
//                             bottomEnd: Radius.circular(10.0),
//                           )
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5.0,
//                             horizontal: 10.0),
//                         child: Text(
//                             'SUUUIIIIII'),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional.centerEnd,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.blue.withOpacity(0.3),
//                           borderRadius: BorderRadiusDirectional.only(
//                             topStart: Radius.circular(10.0),
//                             topEnd: Radius.circular(10.0),
//                             bottomStart: Radius.circular(10.0),
//                           )
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5.0,
//                             horizontal: 10.0),
//                         child: Text(
//                             'SUUUUUUUUUUIIII'),
//                       ),
//                     ),
//                   ),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.grey.withOpacity(0.5),
//                         ),
//                         borderRadius: BorderRadius.circular(15.0),
//                       ),
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       child: Row(
//                         children: [
//                           IconButton(onPressed: (){},
//                               icon: Icon(
//                                   Icons.add_circle
//                               )),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                               child: TextFormField(
//                                 controller: messageController,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'write your message...'
//                                 ),
//                               ),
//                             ),
//                           ),
//                           IconButton(onPressed: (){},
//                               icon: Icon(
//                                   Icons.send
//                               ))
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         }
//       ),
//     );
//   }
//
//   Widget buildMessages() =>Align(
//     alignment: AlignmentDirectional.centerStart,
//     child: Container(
//       decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadiusDirectional.only(
//             topStart: Radius.circular(10.0),
//             topEnd: Radius.circular(10.0),
//             bottomEnd: Radius.circular(10.0),
//           )
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: 5.0,
//             horizontal: 10.0),
//         child: Text(
//             'shiiiiiiiiiiiiiiiiiit'),
//       ),
//     ),
//   );
//   Widget buildMyMessages() =>Align(
//     alignment: AlignmentDirectional.centerEnd,
//     child: Container(
//       decoration: BoxDecoration(
//           color: Colors.blue.withOpacity(0.3),
//           borderRadius: BorderRadiusDirectional.only(
//             topStart: Radius.circular(10.0),
//             topEnd: Radius.circular(10.0),
//             bottomStart: Radius.circular(10.0),
//           )
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: 5.0,
//             horizontal: 10.0),
//         child: Text(
//             'shiiiiiiiiiiiiiiiiiit'),
//       ),
//     ),
//   );
// }
import 'package:buildcondition/buildcondition.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/patient_layout/patient_cubit.dart';
import 'package:graduation_project/layouts/patient_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  // const ChatDetailsScreen({Key? key}) : super(key: key);

  PatientModel? patModel;
  DoctorModel? docModel;
  ChatDetailsScreen({this.docModel,});

  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        PatientCubit.get(context).getMessage(receiverId: docModel!.uId!);
        return BlocConsumer<PatientCubit,PatientStates>(
          listener: (context, state) {},
          builder: (context, state)
          {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${docModel!.image}',
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
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
                                  '${docModel!.fullName}',
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
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    BuildCondition(
                      condition: PatientCubit.get(context).messages.length > 0,
                      builder: (context)=> Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index)
                            {
                              var messages = PatientCubit.get(context).messages[index];
                              if(PatientCubit.get(context).patModel.uId == messages.senderId)
                                return buildMyMessages(messages);

                              return buildMessages(messages);
                            },
                            separatorBuilder:(context, index) => SizedBox(
                              height: 15.0,),
                            itemCount: PatientCubit.get(context).messages.length),
                      ),
                      fallback:(context)=> Expanded(child: Center(child: CircularProgressIndicator())) ,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here...'
                                )  ,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.green,
                            child: IconButton(
                                onPressed: ()
                                {
                                  if(messageController.text != '')
                                  {
                                    PatientCubit.get(context).sendMessage(
                                        receiverId: docModel!.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                  }
                                  messageController.text = '';
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessages(MessagesModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 5.0),
        child: Text(
            '${model.text}'
        ),
      ),
    ),
  );

  Widget buildMyMessages(MessagesModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 5.0),
        child: Text(
            '${model.text}'
        ),
      ),
    ),
  );
}


