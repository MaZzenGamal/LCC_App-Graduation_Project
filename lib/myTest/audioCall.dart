import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:graduation_project/models/call_model.dart';
import '../layouts/app_layout/app_layout.dart';
import '../models/user_model.dart';
import '../shared/components/components.dart';

const APP_ID = "549a436c46ac4ceb8648789358634b61";
final firebase = FirebaseFirestore.instance;
CallsModel callModel = CallsModel();
UserModel userModel = UserModel();

class AudioCallScreen extends StatefulWidget {
  final String? groupId;
  const AudioCallScreen({Key? key, this.groupId}) : super(key: key);

  @override
  _AudioCallScreenState createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  late int _remoteUid = 0;
  late RtcEngine _engine;

  @override
  Future<void> dispose() async {
   // firebase.collection('calls').doc(groupId).delete();

    super.dispose();
    _engine.leaveChannel();
    _engine.destroy();
    // destroy sdk

  /*  try {
      await getCallData();
      await getType();
    } catch (c) {
      print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    }
    if (userModel.type == 'patient') {
      firebase
          .collection('patient')
          .doc(callModel.senderId)
          .update({'inCall': false});
      firebase
          .collection('doctor')
          .doc(callModel.receiverId)
          .update({'inCall': false});
    } else {
      firebase
          .collection('doctor')
          .doc(callModel.senderId)
          .update({'inCall': false});
      firebase
          .collection('patient')
          .doc(callModel.receiverId)
          .update({'inCall': false});
    }*/
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  late String groupId;

  @override
  Widget build(BuildContext context) {
    String? args = ModalRoute.of(context)?.settings.arguments as String?;
    print("audio call id $args");
    groupId = args ?? widget.groupId!;
    print("audio call id $groupId");
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black87,
            child: Center(
              child: _remoteUid == 0
                  ? const Text(
                      "Calling …",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      "Calling with $_remoteUid",
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25),
              child: Container(
                height: 50,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () async {
                          try{
                            await  getCallData();
                            await getType();

                          }catch(c){
                            print("the error in button is ${c}");
                            print("the sender is ${callModel.senderId}");
                            print("the reciver is ${callModel.receiverId}");
                          }
                          if(userModel.type=='patient')
                          {
                            firebase.collection('patient').doc(callModel.senderId).update({'inCall':false});
                            firebase.collection('doctor').doc(callModel.receiverId).update({'inCall':false});
                          }
                          else
                          {
                            firebase.collection('doctor').doc(callModel.senderId).update({'inCall':false});
                            firebase.collection('patient').doc(callModel.receiverId).update({'inCall':false});
                          }
                          await firebase.collection('calls').doc(groupId).delete();
                         try{
                          await _engine.leaveChannel();
                          await _engine.destroy();
                         }
                         catch(error){
                           if (kDebugMode) {
                             print("the error is ${error.toString()}");
                           }
                         }

                          navigateTo(context,const AppLayout());
                        },
                        icon: const Icon(
                          Icons.call_end,
                          size: 44,
                          color: Colors.redAccent,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  init() async {
    initialize();
  }

  Future<void> initialize() async {
    await _initAgoraRtcEngine();
    _engine.joinChannel(null, groupId, null, 0);
  }

  /// Create agora sdk instance and initialze
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        //
          joinChannelSuccess: (String channel, int uid, int elapsed) async {
        try {
          await getCallData();
          await getType();
        } catch (c) {
          print("the error is $c");
        }
        if (userModel.type == 'patient') {
          firebase
              .collection('patient')
              .doc(callModel.senderId)
              .update({'inCall': true});
        } else {
          firebase
              .collection('doctor')
              .doc(callModel.senderId)
              .update({'inCall': true});
        }
        print('local user $uid joined successfully');
      }, userJoined: (int uid, int elapsed) async {
        try {
          await getCallData();
          await getType();
        } catch (c) {
          print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
        }
        if (userModel.type == 'patient') {
          firebase
              .collection('doctor')
              .doc(callModel.receiverId)
              .update({'inCall': true});
        } else {
          firebase
              .collection('patient')
              .doc(callModel.receiverId)
              .update({'inCall': true});
        }
        print('remote user $uid joined successfully');
        setState(() => _remoteUid = uid);
      }, userOffline: (int uid, UserOfflineReason reason) {
        print('remote user $uid left call');
        setState(() => _remoteUid = 0);
        Navigator.of(context).pop(true);
      }, error: (code) {
        print("error error $code");
      }),
    );
  }

  Widget _renderRemoteAudio() {
    if (_remoteUid != 0) {
      return Text(
        "Calling with $_remoteUid",
        style: const TextStyle(color: Colors.white),
      );
    } else {
      return const Text(
        "Calling …",
        style: TextStyle(color: Colors.white),
      );
    }
  }

  Future<void> getCallData() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('calls').doc(groupId).get();
    callModel =
        CallsModel.fromJson(documentSnapshot.data()! as Map<String, dynamic>);
  }

  Future<void> getType() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(callModel.senderId)
        .get();
    userModel =
        UserModel.fromJson(documentSnapshot.data()! as Map<String, dynamic>);
  }
}
