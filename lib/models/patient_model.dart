import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel
{
  String? fullName;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? age;
  String? gender;
  String? address;
  String?token;
  Timestamp?createdAt;

  PatientModel({
    this.fullName,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.age,
    this.gender,
    this.address,
    this.token,
    this.createdAt,
  });
  PatientModel.fromJson(Map<String,dynamic>json)
  {
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    token=json['token'];
    createdAt=json['createdAt'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'fullName':fullName,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'age':age,
      'address':address,
      'gender':gender,
      'token':token,
      'createdAt':createdAt,
    };
  }
}