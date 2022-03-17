import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneModel
{

  String? phone;
  String? uId;

  PhoneModel({
    this.phone,this.uId
  });
  PhoneModel.fromJson(Map<String,dynamic>json)
  {
    phone = json['phone'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'phone':phone,
      'uId':uId,

    };
  }
}