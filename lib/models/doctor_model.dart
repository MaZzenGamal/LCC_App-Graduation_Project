import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel
{
  String? fullName;
  String? email;
  String? phone;
  String? uId;
  String? image;
  int? age;
  String? gender;
  String? maritalStatus;
  String? address;
  String? university;
  String? regisNumber;
  String? specialization;
  String? certificates;
  String? price;
  String? startTime;
  String? endTime;
  String? daysOfWork;
  String? degree;
  String?token;
  Timestamp?createdAt;

  DoctorModel({
    this.fullName,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.age,
    this.gender,
    this.address,
    this.maritalStatus,
    this.university,
    this.regisNumber,
    this.specialization,
    this.certificates,
    this.price,
    this.startTime,
    this.endTime,
    this.daysOfWork,
    this.degree,
    this.token,
    this.createdAt,
  });
  DoctorModel.fromJson(Map<String,dynamic>json)
  {
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    university = json['university'];
    regisNumber = json['regisNumber'];
    specialization = json['specialization'];
    certificates = json['certificates'];
    price = json['price'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    daysOfWork = json['daysOfWork'];
    degree = json['degree'];
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
      'martialStatus':maritalStatus,
      'university':university,
      'regisNumber':regisNumber,
      'specialization':specialization,
      'certificates':certificates,
      'price':price,
      'startTime':startTime,
      'endTime':endTime,
      'daysOfWork':daysOfWork,
      'degree':degree,
      'token':token,
      'createdAt':createdAt,
    };
  }
}