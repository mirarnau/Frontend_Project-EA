import 'dart:convert';
import 'package:flutter_tutorial/config.dart';
import 'package:flutter_tutorial/models/message.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class TicketService {
  var baseUrl = apiURL + "/api/tickets";

  //In Dart, promises are called Future.

  Future<List<Ticket>?> getTicketsByCreator(String creatorName) async {
    var res = await http.get(Uri.parse(baseUrl + '/creator/' + creatorName),
      headers: {'authorization': LocalStorage('key').getItem('token')});
      
    if (res.statusCode == 200) {
      List <Ticket> listTickets = [];
      var decoded = jsonDecode(res.body);
      decoded.forEach((ticket) => listTickets.add(Ticket.fromJSON(ticket)));
      return listTickets;
    }
    return null;
  }

  Future<List<Ticket>?> getTicketsByRecipient(String recipientName) async {
    var res = await http.get(Uri.parse(baseUrl + '/recipient/' + recipientName),
      headers: {'authorization': LocalStorage('key').getItem('token')});
    if (res.statusCode == 200) {
      List <Ticket> listTickets = [];
      var decoded = jsonDecode(res.body);
      decoded.forEach((ticket) => listTickets.add(Ticket.fromJSON(ticket)));
      return listTickets;
    }
    return null;
  }


  Future<bool> updateTicketStatus(Ticket ticket) async {
    var res = await http.put(Uri.parse(baseUrl + '/' + ticket.id),
        headers: {'authorization': LocalStorage('key').getItem('token'), 'content-type': 'application/json'},
        body: json.encode(Ticket.toJson(ticket)));

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<Ticket?> addTicket(Ticket ticket) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: {'authorization': LocalStorage('key').getItem('token'),'content-type': 'application/json'},
        body: json.encode(Ticket.toJson(ticket)));

    if (res.statusCode == 201) {
      Ticket newTicket = Ticket.fromJSON(json.decode(res.body));
      return newTicket;
    }
    return null;
  }

  Future<bool> addMessageToTicket(Message message, Ticket ticket) async {
    var res = await http.post(Uri.parse(baseUrl + '/' + ticket.id),
        headers: {'authorization': LocalStorage('key').getItem('token'),'content-type': 'application/json'},
        body: json.encode(Message.toJson(message)));

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<List<Message>?> getMessagesFromTicket(Ticket ticket) async {
    var res = await http.get(Uri.parse(baseUrl + '/messages/' +  ticket.id),
        headers: {'authorization': LocalStorage('key').getItem('token'),'content-type': 'application/json'});

    if (res.statusCode == 200) {
      List <Message> listMessages = [];
      var decoded = jsonDecode(res.body);
      decoded.forEach((message) => listMessages.add(Message.fromJSON(message)));
      return listMessages;
    }
    return null;
  }
}
