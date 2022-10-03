

class MessageModel
{

  late final String sendId;
  late final String receiverId;
  late final  String dateTime;
  late final String text;


  MessageModel(this.sendId,this.receiverId,this.dateTime,this.text);


  MessageModel.fromJson(Map<String, dynamic> json)
  {
    sendId = json['sendId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];

  }
  Map<String,dynamic> senMessageModel()
  {
    return{
      'sendId':sendId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'text' :text,


    };
  }



}