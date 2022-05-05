import 'package:cloud_firestore/cloud_firestore.dart';

class DocRefModel
{
  String? docRef;


  DocRefModel({
    this.docRef,

    // this.time,
  });

  DocRefModel.fromJson(Map<String,dynamic>json)
  {
    docRef=json['docRef'].toString();
  }

  Map<String,dynamic> toMap()
  {
    return {
      'docRef': docRef,
    };
  }
}