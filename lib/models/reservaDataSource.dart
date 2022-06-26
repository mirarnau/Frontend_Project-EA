import 'package:flutter_tutorial/models/reserva.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Reserva> appointments) {
    this.appointments = appointments;
  }

  Reserva getEvent(int index) => appointments![index] as Reserva;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;
  @override
  DateTime getEndTime(int index) => getEvent(index).to;
  @override
  String getSubject(int index) => getEvent(index).title;
  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
