import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel
{
  String? fullName;
  String? image;
  DateTime?createdAt;
  double? rate;
  String?comment;
  String? senderId;


  CommentModel({
    this.createdAt,
    this.rate,
    this.comment,
    this.senderId
  });
  CommentModel.fromJson(Map<String,dynamic>json)
  {
    createdAt= DateTime.parse(json['createdAt']);
    rate=json['rate'];
    comment=json['comment'];
    senderId=json['senderId'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'createdAt':createdAt?.toIso8601String(),
      'rate':rate,
      'comment':comment,
      'senderId':senderId,
    };
  }
}