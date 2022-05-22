import 'package:flutter_tutorial/models/message.dart';

class Ticket {
  late final String id;
  late final String creatorName;
  late final String recipientName;
  late final String subject;
  late final List<Message> messages;
  late final bool status;
  late final String creationDate;

  Ticket(
    {
      required this.creatorName,
      required this.recipientName,
      required this.subject
    }
  );

  factory Ticket.fromJSON(dynamic json) {
    Ticket ticket = Ticket(
      creatorName: json['creatorName'],
      recipientName: json['recipientName'],
      subject: json['subject']);

    ticket.id = json['_id'];
    ticket.messages = json['messages'].cast<Message>();
    ticket.status = json['status'];
    ticket.creationDate = json['creationDate'];
    return ticket;
  }

  static Map<String, dynamic> toJson (Ticket ticket) {
    return {
      'creatorName': ticket.creatorName,
      'recipientName': ticket.recipientName,
      'subject': ticket.subject,
    };
  }
}