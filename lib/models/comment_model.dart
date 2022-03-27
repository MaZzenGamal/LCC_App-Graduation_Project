import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel
{
  String? fullName;
  String? image;
  Timestamp?createdAt;
  double? rate;
  String?message;
  String? senderId;
  String? receiverId;


  CommentModel({
    this.fullName,
    this.image,
    this.createdAt,
    this.rate,
    this.message,
    this.receiverId,
    this.senderId
  });
  CommentModel.fromJson(Map<String,dynamic>json)
  {
    fullName = json['fullName'];
    image = json['image'];
    createdAt=json['createdAt'];
    rate=json['rate'];
    message=json['message'];
    senderId=json['senderId'];
    receiverId=json['receiverId'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'fullName':fullName,
      'image':image,
      'createdAt':createdAt,
      'rate':rate,
      'message':message,
      'receiverId':receiverId,
      'senderId':senderId,
    };
  }
}