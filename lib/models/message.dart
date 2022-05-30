class Message {
  late final String id;
  late final String senderName;
  late final String receiverName;
  late final String message;
  late final String profilePicSender;
  late final String creationDate;

  Message(
    {
      required this.senderName,
      required this.receiverName,
      required this.message,
      required this.profilePicSender
    }
  );

  factory Message.fromJSON(dynamic json) {
    Message message = Message(
      senderName: json['senderName'] as String,
      receiverName: json['receiverName'],
      message: json['message'],
      profilePicSender: json['profilePicSender']);
    message.id = json['_id'];
    message.creationDate = json ['creationDate'];
    return message;
  }

  static Map<String, dynamic> toJson (Message message) {
    return {
      'senderName': message.senderName,
      'receiverName': message.receiverName,
      'message': message.message,
      'profilePicSender': message.profilePicSender,
    };
  }
}