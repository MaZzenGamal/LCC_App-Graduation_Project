import 'package:flutter/foundation.dart';

class MessagesModel {
  String? senderId;
  String? receiverId;
  DateTime? dateTime;
  String? text;
  bool? read;

  MessagesModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.read,
  });
  MessagesModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = DateTime.parse(json['dateTime']);
    text = json['text'];
    read = json['read'];
  }

  Map<String, dynamic> toMap() {
    if (kDebugMode) {
      print("sender id in map $senderId");
    }
    if (kDebugMode) {
      print("receiver id in map $receiverId");
    }
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime?.toIso8601String(),
      'text': text,
      'read': read
    };
  }
}
