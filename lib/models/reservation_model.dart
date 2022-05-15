
class ReservationModel
{
  DateTime?date;
  String?doctorId;
  String?patientId;
  String?reservationId;
  ReservationModel({
    this.date,
    this.doctorId,
    this.reservationId,
    this.patientId
  });
  ReservationModel.fromJson(Map<String,dynamic>json)
  {
    date=DateTime.parse(json['date']);
    reservationId=json['reservationId'];
    doctorId=json['doctorId'];
    patientId=json['patientId'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'date': date.toString(),
      'doctorId': doctorId,
      'patientId':patientId,
      'reservationId':reservationId,
    };
  }
}