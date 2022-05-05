
class ReservationModel
{
  DateTime?date;
  DateTime?time;
  String?doctorId;
  String?patientId;
  ReservationModel({
    this.date,
    this.doctorId,
    this.time,
    this.patientId
  });
  ReservationModel.fromJson(Map<String,dynamic>json)
  {
    date=DateTime.parse(json['date']);
    time=DateTime.parse(json['time']);
    doctorId=json['doctorId'];
    patientId=json['patientId'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'date': date.toString(),
      'time': time.toString(),
      'doctorId': doctorId,
      'patientId':patientId,
    };
  }
}