import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel
{
  String? fullName;
  String? image;
  DateTime?createdAt;
  double? rate;
  String?message;
  String? senderId;
  String? receiverId;


  CommentModel({
    this.createdAt,
    this.rate,
    this.message,
    this.receiverId,
    this.senderId
  });
  CommentModel.fromJson(Map<String,dynamic>json)
  {
    createdAt= DateTime.parse(json['createdAt']);
    rate=json['rate'];
    message=json['message'];
    senderId=json['senderId'];
    receiverId=json['receiverId'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'createdAt':createdAt?.toIso8601String(),
      'rate':rate,
      'message':message,
      'receiverId':receiverId,
      'senderId':senderId,
    };
  }
}