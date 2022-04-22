import 'package:flutter/foundation.dart';

class CallsModel
{
  String? channelName;

  CallsModel({
    this.channelName

  });
CallsModel.fromJson(Map<String,dynamic>json)
  {
    channelName = json['channelName'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'ChannelName':channelName,
    };
  }
}