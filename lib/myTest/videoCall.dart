import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';

import '../models/call_model.dart';
import '../models/user_model.dart';
//Agora stuff
// replace with your App ID from Agora.io
const APP_ID = "549a436c46ac4ceb8648789358634b61";
final firebase = FirebaseFirestore.instance;
var type = CacheHelper.getData(key: 'type');
var uID = CacheHelper.getData(key: 'uId');
CallsModel callModel=CallsModel();
UserModel userModel=UserModel();

class VideoCallScreen extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String? groupId;
  /// Creates a call page with given channel name.
   VideoCallScreen({Key? key, this.groupId}) : super(key: key);

  @override
  VideoCallScreenState createState() {
    return  VideoCallScreenState();
  }
}

class VideoCallScreenState extends State<VideoCallScreen>{
  late RtcEngine _engine;
  int _remoteUid=0;

  @override
  Future<void> dispose() async {
    firebase.collection('calls').doc(groupId).delete();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
    try{
      await  getCallData();
      await getType();

    }catch(c){
      print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    }
    showToast(text:'the type of sender is ${userModel.type}', state: ToastStates.ERROR);
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
  }

  @override
  void initState(){
    super.initState();
    init();
  }
  late String groupId;
  @override
  Widget build(BuildContext context) {
    String? args = ModalRoute.of(context)?.settings.arguments as String?;
    print("video call id $args");
    groupId = args ?? widget.groupId!;
    print("video call id $groupId");
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(groupId),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150.0),
                child: Container(
                    height: 150, width: 150, child: _renderLocalPreview()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () async {
                        firebase.collection('calls').doc(groupId).delete();
                        Navigator.of(context).pop(true);
                        try{
                          await  getCallData();
                          await getType();

                        }catch(c){
                          print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                        }
                        showToast(text:'the type of sender is ${userModel.type}', state: ToastStates.ERROR);
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
                        showToast(text:'the type of sender is ${userModel.type}', state: ToastStates.ERROR);

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
        ],
      ),
    );
  }

  // initialize agora sdk
  init() async{
    initialize();
  }

  Future<void> initialize() async {

   await _initAgoraRtcEngine();
     _engine.joinChannel(null,groupId, null, 0);
  }


  /// Create agora sdk instance and initialze
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
          joinChannelSuccess: (String channel,int uid,int elapsed) async {
            try{
              await  getCallData();
              await getType();

            }catch(c){
              print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
            }
            showToast(text:'the type of sender is ${userModel.type}', state: ToastStates.ERROR);
            if(userModel.type=='patient') {
              firebase.collection('patient').doc(callModel.senderId).update({'inCall':true});
            }
            else
            {
              firebase.collection('doctor').doc(callModel.senderId).update({'inCall':true});
            }
            print('local user $uid joined successfully');
          },
          userJoined: (int uid,int elapsed) async {
            try{
              await  getCallData();
              await getType();

            }catch(c){
              print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
            }
            showToast(text:'the type of sender is ${userModel.type}', state: ToastStates.ERROR);
            if(userModel.type=='patient')
            {
              firebase.collection('doctor').doc(callModel.receiverId).update({'inCall':true});
            }
            else
            {
              firebase.collection('patient').doc(callModel.receiverId).update({'inCall':true});
            }
            print('remote user $uid joined successfully');
            setState(()=> _remoteUid=uid);
          },

          userOffline: (int uid, UserOfflineReason reason) {
            print('remote user $uid left call');
            setState(() => _remoteUid = 0);
            Navigator.of(context).pop(true);
          },
          error:(code){
            print("error error $code");
          }
      ),
    );
  }
  Widget _renderLocalPreview() {
    return const RtcLocalView.SurfaceView();
  }
  Widget _renderRemoteVideo(String groupId ) {
    if (_remoteUid != 0) {
      print("the group id is ${groupId}");
      return RtcRemoteView.SurfaceView(
        channelId:groupId,
        uid: _remoteUid,
      );
    } else {
      return Text(
        'Calling …',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      );
    }
  }

  /// Toolbar layout
  Future<void> getCallData()
  async {
    DocumentSnapshot documentSnapshot= await FirebaseFirestore.instance.collection('calls').doc(groupId).get();
    callModel=CallsModel.fromJson(documentSnapshot.data()! as Map<String,dynamic>);
  }
  Future<void> getType()
  async{
    DocumentSnapshot documentSnapshot= await FirebaseFirestore.instance.collection('user').doc(callModel.senderId).get();
    userModel=UserModel.fromJson(documentSnapshot.data()! as Map<String,dynamic>);

  }
}
