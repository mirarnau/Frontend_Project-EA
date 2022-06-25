import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tutorial/pages/eventEditingPage.dart';
import 'package:flutter_tutorial/provider/reservaProvider.dart';
import 'package:flutter_tutorial/widgets/calendarWidget.dart';
import 'package:provider/provider.dart';

class Agenda extends StatefulWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: MaterialApp(
          body: CalendarWidget(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.red,
            onPressed: () => Navigator.of(context).push(EventEditingPage()),
          ),
        ),
      );
}
