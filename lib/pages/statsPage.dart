import 'dart:ui';

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
    _Restaurants('Bokoto', 'Jan', '2020', 3),
    _Restaurants('Tagliatella', 'Jan', '2020', 4),
    _Restaurants('Mare', 'Jan', '2020', 5),
    _Restaurants('Bokoto', 'Feb', '2020', 4),
    _Restaurants('Tagliatella', 'Feb', '2020', 4.5),
    _Restaurants('Mare', 'Feb', '2020', 3.5),
    _Restaurants('XTreme', 'Feb', '2020', 1),
    _Restaurants('Vicio', 'Feb', '2020', 2),

    _Restaurants('Bokoto', 'Jan', '2021', 4),
    _Restaurants('Tagliatella', 'Jan', '2021', 3),
    _Restaurants('Mare', 'Jan', '2021', 2),
    _Restaurants('Bokoto', 'Feb', '2021', 2.4),
    _Restaurants('Tagliatella', 'Feb', '2021', 4),
    _Restaurants('Mare', 'Feb', '2021', 3),
    _Restaurants('XTreme', 'Feb', '2021', 1.5),
    _Restaurants('Vicio', 'Feb', '2021', 2.7)
  ];

  List<_Restaurants> data_year = [
    _Restaurants('Bokoto', 'Feb', '2020', 3),
    _Restaurants('Tagliatella', 'Feb', '2020', 2),
    _Restaurants('Mare', 'Feb', '2020', 3),
    _Restaurants('XTreme', 'Feb', '2020', 1.4),
    _Restaurants('Vicio', 'Feb', '2020', 2.3),

    _Restaurants('Bokoto', 'Feb', '2021', 2.8),
    _Restaurants('Tagliatella', 'Feb', '2021', 2),
    _Restaurants('Mare', 'Feb', '2021', 3.4),
    _Restaurants('XTreme', 'Feb', '2021', 1.5),
    _Restaurants('Vicio', 'Feb', '2021', 2.5)
  ];

  late List<_Restaurants> monthlydata = [];
  late List<_Restaurants> yearlydata = [];
  static const keyMonth = 'key-month';
  static const keyYear = 'key-year';
  late String month = "Jan";
  late String year = "2020";

  Future<void> monthlyRate(List<_Restaurants> data) async {
    monthlydata.clear();
    for (_Restaurants rest in data) {
      if (rest.restMonth == month && rest.restYear == year) {
        monthlydata.add(rest);
      }
    }
  }

  Future<void> yearlyRate(List<_Restaurants> data) async {
    yearlydata.clear();
    for (_Restaurants rest in data) {
      if (rest.restYear == year) {
        yearlydata.add(rest);
      }
    }
  }
  
  @override
  void initState() {
    monthlyRate(data);
    yearlyRate(data_year);
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
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children:  [
                      SizedBox(
                        width: 175,
                        child: buildMonth(context: context),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2.5),
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children:  [
                      SizedBox(
                        width: 175,
                        child: buildYear(context: context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            child: 
            Padding(
              padding: const EdgeInsets.all(3),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                  text: 'Rating: ' + month + ', ' +  year,
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_Restaurants, String>>[
                  BarSeries<_Restaurants, String>(
                    dataSource: monthlydata,
                    xValueMapper: (_Restaurants restRate, _) => restRate.restName,
                    yValueMapper: (_Restaurants restRate, _) => restRate.restRate,
                    name: 'Rating',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            child: 
            Padding(
              padding: const EdgeInsets.all(3),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                  text: 'Rating: ' +  year,
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_Restaurants, String>>[
                  BarSeries<_Restaurants, String>(
                    dataSource: yearlydata,
                    xValueMapper: (_Restaurants restRate, _) => restRate.restName,
                    yValueMapper: (_Restaurants restRate, _) => restRate.restRate,
                    name: 'Rating',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ),


          /* INTENT DE GRÁFIC DE BARRES
            SizedBox(
            height: 200,
            width: 320,
            child: 
            Padding(
              padding: const EdgeInsets.all(5),
              child: SfSparkBarChart.custom(
                xValueMapper: (int index) => monthlydata[index].restName,
                yValueMapper: (int index) => monthlydata[index].restRate,
                dataCount: monthlydata.length,
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                trackball: const SparkChartTrackball(
                  width: 2,
                  color: Colors.black, 
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          */
        ],
      ),
    );
  }

  Widget buildMonth({required BuildContext context}) => DropDownSettingsTile(
    settingKey: keyMonth,
    title: "Month",
    selected: 1,
    values: const <int, String> {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec"
    },
    onChange: (month) {
      if(month == 1) this.month = "Jan";
      if(month == 2) this.month = "Feb";
      if(month == 3) this.month = "Mar";
      if(month == 4) this.month = "Apr";
      if(month == 5) this.month = "May";
      if(month == 6) this.month = "Jun";
      if(month == 7) this.month = "Jul";
      if(month == 8) this.month = "Aug";
      if(month == 9) this.month = "Sep";
      if(month == 10) this.month = "Oct";
      if(month == 11) this.month = "Nov";
      if(month == 12) this.month = "Dec";
      monthlyRate(data);
      setState(() {
        
      });
    },
  );

  Widget buildYear({required BuildContext context}) => DropDownSettingsTile(
    settingKey: keyYear,
    title: "Year",
    selected: 1,
    values: const <int, String> {
      1: "2020",
      2: "2021",
      3: "2022",
    },
    onChange: (year) {
      if(year == 1) this.year = "2020";
      if(year == 2) this.year = "2021";
      if(year == 3) this.year = "2022";
      yearlyRate(data_year);
      monthlyRate(data);
      setState(() {
        
      });
    },
  );
}

class _Restaurants {
  _Restaurants(this.restName, this.restMonth, this.restYear, this.restRate);

  final String restName;
  final String restMonth;
  final String restYear;
  final double restRate;
}