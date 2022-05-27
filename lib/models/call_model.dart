import 'package:flutter/foundation.dart';

class CallsModel
{
  String? channelName;
  String? senderId;
  String? receiverId;


  CallsModel({
    this.channelName,
    this.senderId,
    this.receiverId

  });
CallsModel.fromJson(Map<String,dynamic>json)
  {
    channelName = json['channelName'];
    senderId=json['senderId'];
    receiverId=json['receiverId'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'channelName':channelName,
      'senderId':senderId,
      'receiverId':receiverId,
    };
  }
}