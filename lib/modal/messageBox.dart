class MessageBox {
  int senderID;
  int receiverID;
  String messageText;

  MessageBox(
      {required this.senderID,
      required this.receiverID,
      required this.messageText});

  factory MessageBox.fromJson(Map<String, dynamic> json) {
    return MessageBox(senderID: json['senderID'], receiverID: json['receiverID'], messageText: json['message']);
  }
}
