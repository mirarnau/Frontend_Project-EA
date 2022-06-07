import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/widgets/iconWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StatsPage extends StatefulWidget {
  final List<Restaurant>? restaurants;
  StatsPage({Key? key, required this.restaurants}) : super(key: key);

  @override
  _StatsPage createState() => _StatsPage();
}

class _StatsPage extends State<StatsPage> {
  List<_Restaurants> data = [
    _Restaurants('Bokoto', 'January', 3),
    _Restaurants('Tagliatella', 'January', 4),
    _Restaurants('Mare', 'January', 5),
    _Restaurants('Bokoto', 'February', 4),
    _Restaurants('Tagliatella', 'February', 4.5),
    _Restaurants('Mare', 'February', 3.5),
    _Restaurants('XTreme', 'February', 1),
    _Restaurants('Vicio', 'February', 2)
  ];



  late List<_Restaurants> realdata = [];
  static const keyMonth = 'key-month';
  late String month = "January";

  Future<void> monthlyRate(List<_Restaurants> data) async {
    realdata = [];
    for (_Restaurants rest in data) {
      if (rest.restMonth == month) {
        realdata.add(rest);
      }
    }
  }

  @override
  void initState() {
    monthlyRate(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: const Text('Rating Chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          buildMonth(context: context),

          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Restaurants Rating of ' + month),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_Restaurants, String>>[
                LineSeries<_Restaurants, String>(
                    dataSource: realdata,
                    xValueMapper: (_Restaurants restRate, _) => restRate.restName,
                    yValueMapper: (_Restaurants restRate, _) => restRate.restRate,
                    name: 'Rating',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]
            ),
        ],
      ),
    );
  }

  Widget buildMonth({required BuildContext context}) => DropDownSettingsTile(
    settingKey: keyMonth,
    title: "Month",
    selected: 1,
    values: const <int, String> {
      1: "January",
      2: "February",
      3: "March",
    },
    onChange: (month) {
      if(month == 1) this.month = "January";
      if(month == 2) this.month = "February";
      if(month == 3) this.month = "March";
      monthlyRate(data);
      setState(() {
        
      });
    },
  );
}

class _Restaurants {
  _Restaurants(this.restName, this.restMonth, this.restRate);

  final String restName;
  final String restMonth;
  final double restRate;
}
