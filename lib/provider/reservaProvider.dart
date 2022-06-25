import 'package:flutter_tutorial/models/reserva.dart';
import 'package:flutter_tutorial/utils.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  final List<Reserva> _reserves = [];

  List<Reserva> get reserves => _reserves;
  DateTime _selelectedDate = DateTime.now();

  DateTime get selectedDate => _selelectedDate;

  void setDate(DateTime date) => _selelectedDate = date;

  List<Reserva> get eventsOfSelectedDate => _reserves;
  void addEvent(Reserva reserva) {
    _reserves.add(reserva);

    notifyListeners();
  }
}
