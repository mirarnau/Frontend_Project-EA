// ignore_for_file: prefer_const_constructors, unnecessary_this, deprecated_member_use

import 'dart:convert';

import 'package:dialog_flowtter/dialog_flowtter.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_tutorial/models/message.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/createTicketPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/ticketWidget.dart';
import 'package:flutter_tutorial/services/ticketsService.dart';

class ChatBotPage extends StatefulWidget {

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {

  final TextEditingController _controller = TextEditingController();

  late List data =  [];
  late DialogAuthCredentials myCredentials;
  late DialogFlowtter _dialogFlowtter;

  @override
  void initState()  {
  super.initState();
  this.loadJsonData();

  }

  Future<void> loadJsonData() async { 
    myCredentials =  await DialogAuthCredentials.fromFile('assets/dialog_flow_auth.json');
    _dialogFlowtter =  DialogFlowtter(credentials: myCredentials);
  }

  
  List<Map<String, dynamic>> messages = [];

  void sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {
      Message userMessage = Message(text: DialogText(text: [text]));
      addMessage(userMessage, true);
    });
    QueryInput query = QueryInput(text: TextInput(text: text));

    DetectIntentResponse res = await _dialogFlowtter.detectIntent(
      queryInput: query,
    );

    if (res.message == null) return;
    setState(() {
      addMessage(res.message as Message);
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Bot')),
      body: Column(
        children: [
          Expanded(
            child: _MessagesList(messages: messages),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Color.fromARGB(255, 43, 43, 43),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _controller,
                    cursorColor: Colors.white,
                  ),
                ),
                IconButton(
                  color: Color.fromARGB(255, 213, 94, 85),
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _MessagesList extends StatelessWidget {
  /// El componente recibirá una lista de mensajes
  final List<Map<String, dynamic>> messages;

  const _MessagesList({
    this.messages = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: messages.length,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      separatorBuilder: (_, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        var obj = messages[messages.length - 1 - i];
        return _MessageContainer(
          message: obj['message'],
          isUserMessage: obj['isUserMessage'],
        );
      },
      reverse: true,
    );
  }
}

class _MessageContainer extends StatelessWidget {
  final Message message;
  final bool isUserMessage;

  const _MessageContainer({
    required this.message,
    this.isUserMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 250),
          child: Container(
            decoration: BoxDecoration(
              color: isUserMessage ? Color.fromARGB(255, 96, 135, 166) : Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              message.text?.text![0] ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}