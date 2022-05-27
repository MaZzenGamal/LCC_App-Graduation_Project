//ignore_for_file: must_be_immutable
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../myTest/audioCall.dart';
import '../../myTest/videoCall.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';
/////////////// patient in login this chat between patient and doctor
class ChatPatientScreen extends StatelessWidget {
  //ChatDetailsScreen({Key? key}) : super(key: key);

  PatientModel? patModel;
  DoctorModel? docModel;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final firebase = FirebaseFirestore.instance;
  var uID = CacheHelper.getData(key: 'uId');
  //ChatDetailsScreen({Key? key, patModel, docModel}) : super(key: key);
  ChatPatientScreen({Key? key, this.docModel})
      : super(key: key);

  var messageController = TextEditingController();
late var size1;
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    size1=size;
    DoctorModel? args = ModalRoute.of(context)?.settings.arguments as DoctorModel?;
      print(args);
    final _docModel = args ?? docModel;
    /*FirebaseMessaging.onMessageOpenedApp.listen((event) {
      navigateTo(context, ChatDetailsScreenDoctor(patModel: patModel,index:index));
    });*/
    return Builder(builder: (BuildContext context) {
      AppCubit.get(context).getMessage(receiverId: _docModel?.uId as String);
      AppCubit.get(context).getUserData();
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
                        '${_docModel!.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${_docModel.fullName}',
                      style: const TextStyle(fontSize: 15.0),
                    )
                  ],
                ),
                actions: [
                  IconButton(onPressed: () async{
                    if(_docModel.inCall!) {
                      showToast(text:'Doctor is in another call please try later', state: ToastStates.ERROR);
                    }
                    else{
                      AppCubit.get(context).createCall(
                          receiverId: _docModel.uId!,
                          senderId: uID
                      );
                      await [Permission.microphone]
                          .request();
                      navigateTo(
                          context,
                          AudioCallScreen(
                            groupId: uID,
                          ));
                      AppCubit.get(context).sendNotfiy('${AppCubit
                          .get(context)
                          .patModel
                          .fullName}', 'you have a new call', _docModel.token!,
                          'audio');
                    }
                  }, icon: const Icon(Icons.call)),
                  IconButton(
                      onPressed: () async {
                        if(_docModel.inCall!) {
                          showToast(text:'Doctor is in another call please try later', state: ToastStates.ERROR);
                        }
                        else
                          {
                            AppCubit.get(context).createCall(
                                receiverId: _docModel.uId!,
                                senderId: uID
                            );
                            await [Permission.microphone, Permission.camera]
                                .request();
                            navigateTo(
                                context,
                                VideoCallScreen(
                                  groupId: uID,
                                ));
                            AppCubit.get(context).sendNotfiy('${AppCubit
                                .get(context)
                                .patModel
                                .fullName}', 'you have a new call', _docModel
                                .token!, 'video');
                          }
                        },
                      icon: const Icon(Icons.video_call)),
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
                              var message =
                              AppCubit.get(context).messages[index];
                              if (AppCubit.get(context).uID ==
                                  message.senderId) {
                                return buildMyMessages(message,context);
                              }
                              return buildMessages(message,context);
                            },
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 15.0,
                            ),
                            itemCount: AppCubit.get(context).messages.length),
                      ),
                      fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        String docuid = _docModel.uId!;
                                        firebase
                                            .collection('doctor')
                                            .doc(uID)
                                            .update({'createdAt': DateTime.now().toString()});
                                        firebase
                                            .collection('patient')
                                            .doc(docuid)
                                            .update({'createdAt': DateTime.now().toString()});
                                        AppCubit.get(context).getChatImage(
                                          receiverId: _docModel.uId!,
                                          token: _docModel.token!,
                                          dateTime:DateTime.now(),
                                        );
                                      },
                                      icon: const Icon(Icons.photo),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'write your message...'),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if (messageController.text != '') {
                                  String docuid = _docModel.uId!;
                                  firebase
                                      .collection('doctor')
                                      .doc(uID)
                                      .update({'createdAt': DateTime.now().toString()});
                                  firebase
                                      .collection('patient')
                                      .doc(docuid)
                                      .update({'createdAt': DateTime.now().toString()});
                                  AppCubit.get(context).sendMessage(
                                    receiverId: _docModel.uId!,
                                    dateTime: DateTime.now(),
                                    token: _docModel.token!,
                                    text: messageController.text,
                                  );
                                }
                                messageController.text = '';
                              },
                              icon: const Icon(Icons.send))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    });
  }
  Widget buildMessages(MessagesModel model,BuildContext context){
    return model.type=='text'?Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text('${model.text}'),
        ),
      ),
    ): Container(
      height: size1.height / 2.5,
      width: size1.width,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: AlignmentDirectional.centerStart,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ShowImage(
              imageUrl:model.text!,
            ),
          ),
        ),
        child: Container(
          height: size1.height / 2.5,
          width: size1.width / 2,
          decoration: BoxDecoration(border: Border.all()),
          alignment: model.text!= "" ? null : AlignmentDirectional.centerStart,
          child: model.text != ""
              ? Image.network(
            model.text!,
            fit: BoxFit.cover,
          )
              : const CircularProgressIndicator(),
        ),
      ),
    );

  }
  Widget buildMyMessages(MessagesModel model,BuildContext context){
    return model.type=='text'?Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text('${model.text}'),
        ),
      ),
    ): Container(
      height: size1.height / 2.5,
      width: size1.width,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: AlignmentDirectional.centerEnd,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ShowImage(
              imageUrl:model.text!,
            ),
          ),
        ),
        child: Container(
          height: size1.height / 2.5,
          width: size1.width / 2,
          decoration: BoxDecoration(border: Border.all()),
          alignment: model.text!= "" ? null : AlignmentDirectional.centerEnd,
          child: model.text != ""
              ? Image.network(
            model.text!,
            fit: BoxFit.cover,
          )
              : const CircularProgressIndicator(),
        ),
      ),
    );

  }
}
class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
