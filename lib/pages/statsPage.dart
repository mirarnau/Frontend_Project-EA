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
    _Restaurants('Bokoto', 3),
    _Restaurants('Tagliatella', 4),
    _Restaurants('Mare', 5),
    _Restaurants('XTreme', 1),
    _Restaurants('Vicio', 2)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Restaurants Rating'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_Restaurants, String>>[
                LineSeries<_Restaurants, String>(
                    dataSource: data,
                    xValueMapper: (_Restaurants restRate, _) => restRate.restName,
                    yValueMapper: (_Restaurants restRate, _) => restRate.restRate,
                    name: 'Rating',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]
            ),
        ]));
  }
}

class _Restaurants {
  _Restaurants(this.restName, this.restRate);

  final String restName;
  final double restRate;
}
