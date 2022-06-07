import 'dart:convert';
import 'dart:math';
import 'package:flutter_tutorial/models/reservation.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

import '../config.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

late Map<DateTime, List<Appointment>> _dataCollection;

class _AgendaPageState extends State<AgendaPage> {
  late var _calendarDataSource;

  @override
  void initState() {
    _dataCollection = getAppointments();
    _calendarDataSource = MeetingDataSource(<Appointment>[]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      dataSource: _calendarDataSource,
      firstDayOfWeek: 1,
      loadMoreWidgetBuilder:
          (BuildContext context, LoadMoreCallback loadMoreAppointments) {
        return FutureBuilder(
          future: loadMoreAppointments(),
          builder: (context, snapShot) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            );
          },
        );
      },
    );
  }

  Map<DateTime, List<Appointment>> getAppointments() {
    final List<String> _subjectCollection = <String>[];
    _subjectCollection.add('Reserva Restaurant 1');
    _subjectCollection.add('Reserva Restaurant 2');
    _subjectCollection.add('Reserva Restaurant 3');
    _subjectCollection.add('Reserva Restaurant 4');
    _subjectCollection.add('Reserva Restaurant 5');
    _subjectCollection.add('Reserva Restaurant 6');

    final List<Color> _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));

    final Random random = Random();
    var _dataCollection = <DateTime, List<Appointment>>{};
    final DateTime today = DateTime.now();
    final DateTime rangeStartDate = DateTime(today.year, today.month, today.day)
        .add(const Duration(days: -1000));
    final DateTime rangeEndDate = DateTime(today.year, today.month, today.day)
        .add(const Duration(days: 1000));
    for (DateTime i = rangeStartDate;
        i.isBefore(rangeEndDate);
        i = i.add(Duration(days: 1 + random.nextInt(2)))) {
      final DateTime date = i;
      final int count = 1 + random.nextInt(3);
      for (int j = 0; j < count; j++) {
        final DateTime startDate = DateTime(
            date.year, date.month, date.day, 8 + random.nextInt(8), 0, 0);
        final int duration = random.nextInt(3);
        final Appointment meeting = Appointment(
            subject: _subjectCollection[random.nextInt(6)],
            startTime: startDate,
            endTime:
                startDate.add(Duration(hours: duration == 0 ? 1 : duration)),
            color: _colorCollection[random.nextInt(6)],
            isAllDay: false);

        if (_dataCollection.containsKey(date)) {
          final List<Appointment> meetings = _dataCollection[date]!;
          meetings.add(meeting);
          _dataCollection[date] = meetings;
        } else {
          _dataCollection[date] = [meeting];
        }
      }
    }
    return _dataCollection;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future.delayed(Duration(seconds: 1));
    final List<Appointment> meetings = <Appointment>[];
    DateTime appStartDate = startDate;
    DateTime appEndDate = endDate;

    while (appStartDate.isBefore(appEndDate)) {
      final List<Appointment>? data = _dataCollection[appStartDate];
      if (data == null) {
        appStartDate = appStartDate.add(Duration(days: 1));
        continue;
      }
      for (final Appointment meeting in data) {
        if (appointments!.contains(meeting)) {
          continue;
        }
        meetings.add(meeting);
      }
      appStartDate = appStartDate.add(Duration(days: 1));
    }
    appointments!.addAll(meetings);
    notifyListeners(CalendarDataSourceAction.add, meetings);
  }
}
//----------------------------------------------------------------------------------------------------------------------------------------
  /*final MeetingDataSource _events = MeetingDataSource(<_Meeting>[]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SafeArea(
                    child: SfCalendar(
                  initialDisplayDate: DateTime(2017, 05, 01),
                  view: CalendarView.month,
                  allowedViews: const [
                    CalendarView.day,
                    CalendarView.week,
                    CalendarView.workWeek,
                    CalendarView.month,
                    CalendarView.timelineDay,
                    CalendarView.timelineWeek,
                    CalendarView.timelineWorkWeek,
                    CalendarView.timelineMonth,
                    CalendarView.schedule,
                  ],
                  dataSource: _events,
                  loadMoreWidgetBuilder: loadMoreWidget,
                )),
              )
            ],
          ),
        )));
  }

  Widget loadMoreWidget(
      BuildContext context, LoadMoreCallback loadMoreAppointments) {
    return FutureBuilder<void>(
      initialData: 'loading',
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      },
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  var baseUrl = apiURL + "/api/reservations";

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    http.Response data = await http.get(Uri.parse(
        "https://js.syncfusion.com/demos/ejservices/api/Schedule/LoadData"));
    //http.Response data = await http.get(Uri.parse(baseUrl));
    dynamic jsonData = json.decode(data.body);
    /*List<Reservation> allReservations = [];
    var decoded = jsonDecode(data.body);
    decoded.forEach((reservation) =>
        allReservations.add(Reservation.fromJSON(reservation)));*/

    final List<_Meeting> appointmentData = [];
    for (dynamic data in jsonData) {
      _Meeting meetingData = _Meeting(
          data['Subject'],
          _convertDateFromString(
            data['StartTime'],
          ),
          _convertDateFromString(data['EndTime']),
          Colors.red,
          data['AllDay']);
      appointmentData.add(meetingData);
    }

    appointments.addAll(appointmentData);
    notifyListeners(CalendarDataSourceAction.add, appointmentData);
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}

class _Meeting {
  _Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}*/
