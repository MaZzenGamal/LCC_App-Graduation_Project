
class DoctorModel
{
  String? fullName;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? age;
  String? gender;
  String? address;
  String? university;
  String? regisNumber;
  String? specialization;
  String? certificates;
  String? price;
  String? bio;
  DateTime? startTime;
  DateTime? endTime;
  String? daysOfWork;
  String? day;
  String?token;
  DateTime?createdAt;
  double?rate;
  int?experience;
  double?allRateValue;
  int?allRateNumber;
  bool?inCall;
  DoctorModel({
    this.fullName,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.age,
    this.gender,
    this.address,
    this.university,
    this.regisNumber,
    this.specialization,
    this.certificates,
    this.price,
    this.startTime,
    this.endTime,
    this.bio,
    this.daysOfWork,
    this.day,
    this.token,
    this.createdAt,
    this.rate,
    this.experience,
    this.allRateNumber,
    this.allRateValue,
    this.inCall,
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
    bio = json['bio'];
    startTime = DateTime.parse(json['startTime']);
    endTime = DateTime.parse(json['endTime']);
    daysOfWork = json['daysOfWork'];
    day = json['day'];
    token=json['token'];
    createdAt= DateTime.parse(json['createdAt']);
    rate=json['rate'];
    experience=json['experience'];
    allRateNumber=json['allRateNumber'];
    allRateValue=json['allRateValue'];
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
      'university':university,
      'regisNumber':regisNumber,
      'specialization':specialization,
      'certificates':certificates,
      'price':price,
      'bio':bio,
      'startTime':startTime?.toString(),
      'endTime':endTime?.toString(),
      'daysOfWork':daysOfWork,
      'day':day,
      'token':token,
      'createdAt':createdAt?.toString(),
      'rate':rate,
      'experience':experience,
      'allRateValue':allRateValue,
      'allRateNumber':allRateNumber,
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
      'university':university,
      'regisNumber':regisNumber,
      'specialization':specialization,
      'certificates':certificates,
      'price':price,
      'bio':bio,
      'startTime':startTime,
      'endTime':endTime,
      'daysOfWork':daysOfWork,
      'day':day,
      'token':token,
      'createdAt':createdAt ,
      'rate':rate,
      'experience':experience,
      'allRateValue':allRateValue,
      'allRateNumber':allRateNumber,
      'inCall':inCall,
    };
  }
}