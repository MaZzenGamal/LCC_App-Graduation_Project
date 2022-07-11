
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
  String? token;
  DateTime?createdAt;
  String?day;
  bool? inCall;

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
    this.day,
    this.inCall,
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
   createdAt= DateTime.parse(json['createdAt']);
   day= json['day'];
   inCall=json['inCall'];
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
      'createdAt':createdAt?.toString(),
      'day':day,
      'inCall':inCall,
    };
  }
  Map<String,dynamic> toJson()
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
      'createdAt':createdAt?.toString(),
      'day':day,
      'inCall':inCall,
    };
  }
}