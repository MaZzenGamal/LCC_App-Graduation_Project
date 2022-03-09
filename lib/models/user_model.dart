class UserModel
{

  String? email;
  String? type;
  String? uId;

  UserModel({
    this.email,
    this.type,
    this.uId,
  });
  UserModel.fromJson(Map<String,dynamic>json)
  {
    email = json['email'];
   type = json['type'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'email':email,
      'uId':uId,
      'type':type,
    };
  }
}