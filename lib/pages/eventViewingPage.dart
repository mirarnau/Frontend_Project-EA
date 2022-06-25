import 'package:flutter_tutorial/models/reserva.dart';
import 'package:flutter_tutorial/provider/reservaProvider.dart';
import 'package:flutter_tutorial/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventViewingPage extends StatelessWidget {
  final Reserva event;
  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: <Widget>[
          SizedBox(height: 32),
          Text(
            event.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            event.description,
            style: TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ));
}
