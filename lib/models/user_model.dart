class UserModel
{

  String? email;
  String? type;
  String? uId;
  String?gender;
  String?status;
  String?name;

  UserModel({
    this.email,
    this.type,
    this.uId,
    this.gender,
    this.status,
    this.name
  });
  UserModel.fromJson(Map<String,dynamic>json)
  {
    email = json['email'];
   type = json['type'];
    uId = json['uId'];
    gender=json['gender'];
    status=json['status'];
    name=json['name'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'email':email,
      'uId':uId,
      'type':type,
      'gender':gender,
      'status':status,
      'name':name,
    };
  }
}