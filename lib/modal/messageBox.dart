class MessageBox {
  int senderID;
  int receiverID;
  List<Message>? messageText;

  MessageBox(
      {required this.senderID,
      required this.receiverID,
      required this.messageText});

  factory MessageBox.fromJson(Map<String, dynamic> json) {
    return MessageBox(senderID: 1, receiverID: 1, messageText: []);
  }
}

class Message {
  String? textMessage;
  String? sendTime;

  Message({required this.textMessage, required this.sendTime});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(textMessage: json['message'], sendTime: json['timeStamp']);
  }
}
