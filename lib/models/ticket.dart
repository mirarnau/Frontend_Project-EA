//import 'dart:ffi';

class Ticket {
  late final String id;
  late final String creatorName;
  late final String recipientName;
  late final String subject;
  late final String message;
  late final String profilePicCreator;
  late final bool status;
  late final String creationDate;

  Ticket(
      {required this.id,
      required this.creatorName,
      required this.recipientName,
      required this.subject,
      required this.message,
      required this.profilePicCreator,
      required this.status,
      required this.creationDate});

  factory Ticket.fromJSON(dynamic json) {
    Ticket ticket = Ticket(
        id: json['_id'],
        creatorName: json['creatorName'] as String,
        recipientName: json['recipientName'],
        subject: json['subject'],
        message: json['message'],
        profilePicCreator: json['profilePicCreator'],
        status: json['status'],
        creationDate: json['creationDate']);
    return ticket;
  }

  static Map<String, dynamic> toJson(Ticket ticket) {
    return {
      '_id': ticket.id,
      'creatorName': ticket.creatorName,
      'recipientName': ticket.recipientName,
      'subject': ticket.subject,
      'message': ticket.message,
      'profilePicCreator': ticket.profilePicCreator,
      'status': ticket.status,
    };
  }
}
