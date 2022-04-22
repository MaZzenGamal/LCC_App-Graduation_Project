import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
//Agora stuff
// replace with your App ID from Agora.io
const APP_ID = "549a436c46ac4ceb8648789358634b61";
final firebase = FirebaseFirestore.instance;
var type = CacheHelper.getData(key: 'type');
var uID = CacheHelper.getData(key: 'uId');

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
  static final _users=<int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  late RtcEngine _engine;
  int _remoteUid=0;

  @override
  void dispose() {
    // clear users
    _users.clear();
    if (type == 'patient') {
      firebase.collection('patient').doc(uID).collection(
          'calls').doc(
          uID).delete();
    }
    else if (type == 'doctor') {
      firebase.collection('patient').doc(uID).collection(
          'calls').doc(
          uID).delete();
    }
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
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
                      onPressed: () {
                        if (type == 'patient') {
                          firebase.collection('patient').doc(uID).collection(
                              'calls').doc(
                              uID).delete();
                        }
                        else if (type == 'doctor') {
                          firebase.collection('patient').doc(uID).collection(
                              'calls').doc(
                              uID).delete();
                        }
                        Navigator.of(context).pop(true);
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
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings
            .add("APP_ID missing, please provide your APP_ID in settings.dart");
        _infoStrings.add("Agora Engine is not starting");
      });
      return;
    }

   await _initAgoraRtcEngine();
     _engine.joinChannel(null, widget.groupId!, null, 0);
  }


  /// Create agora sdk instance and initialze
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
       joinChannelSuccess: (String channel,int uid,int elapsed){
          print('local user $uid joined successfully');
        },
        userJoined: (int uid,int elapsed){
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
  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        channelId:widget.groupId!,
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
  Widget _toolbar() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.symmetric(vertical: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () => _onToggleMute(),
                  child: new Icon(
                    muted ? Icons.mic : Icons.mic_off,
                    color: muted ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
                RawMaterialButton(
                  onPressed: () => _onSwitchCamera(),
                  child: new Icon(
                    Icons.switch_camera,
                    color: Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Info panel to show logs

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

}

/*import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/myTest/appBrain.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;*/

//import '../shared/network/local/cash_helper.dart';
//import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

//class VideoCallScreen extends StatefulWidget {
 // const VideoCallScreen({Key? key}) : super(key: key);

 // @override
 // _VideoCallScreenState createState() => _VideoCallScreenState();
//}

//class _VideoCallScreenState extends State<VideoCallScreen> {

  //late int _remoteUid = 0 ;
  //late RtcEngine _engine;
  //var uID = CacheHelper.getData(key: 'uId');
  //var type = CacheHelper.getData(key: 'type');
 // final firebase = FirebaseFirestore.instance;

  //@override
  //void initState() {
    //super.initState();
    //initAgora();
  //}
  /*@override
  void dispose() {
    if(type=='patient')
    {
      firebase.collection('patient').doc(uID).collection('calls').doc(
          uID).delete();
    }
    else if(type=='doctor'){
      firebase.collection('patient').doc(uID).collection('calls').doc(
          uID).delete();
    }
    super.dispose();
    _engine.leaveChannel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
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
                      onPressed: () {
                        if(type=='patient')
                        {
                          firebase.collection('patient').doc(uID).collection('calls').doc(
                              uID).delete();
                        }
                        else if(type=='doctor'){
                          firebase.collection('patient').doc(uID).collection('calls').doc(
                              uID).delete();
                        }
                        Navigator.of(context).pop(true);
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


  Future<void> initAgora() async{
    _engine = await RtcEngine.create(AgoraManager.appId);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel,int uid,int elapsed){
          print('local user $uid joined successfully');
        },
        userJoined: (int uid,int elapsed){
          print('remote user $uid joined successfully');
          setState(()=> _remoteUid=uid);
        },

        userOffline: (int uid, UserOfflineReason reason) {
          if (kDebugMode) {
            print('remote user $uid left call');
          }
          setState(() => _remoteUid = 0);
          Navigator.of(context).pop(true);
        },
      ),
    );
    await _engine.joinChannel(null, uID, null, 0);*/
    //await _engine.joinChannel(AgoraManager.token, AgoraManager.channelName, null, 0);

 /* }

  Widget _renderLocalPreview() {
    return const RtcLocalView.SurfaceView();
  }
  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        channelId:uID,
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
}*/