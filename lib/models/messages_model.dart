class MessagesModel
{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;

  MessagesModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
  });
  MessagesModel.fromJson(Map<String,dynamic>json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String,dynamic> toMap()
  {
    print("sender id in map ${senderId}");
    print("reciver id in map ${receiverId}");
    return{
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'text':text,
    };
  }
}