// ignore_for_file: non_constant_identifier_names, file_names


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class StatsPage extends StatefulWidget {
  final List<Restaurant>? restaurants;
  final Owner? owner;
  const StatsPage({Key? key, required this.restaurants, required this.owner}) : super(key: key);

  @override
  _StatsPage createState() => _StatsPage();
}

class _StatsPage extends State<StatsPage> {
  RestaurantService restaurantService = RestaurantService();
  List<Restaurant>? listRestaurants;
  List<_Restaurants>? dataRestaurants = [];

  late List<_Restaurants> monthlydata = [];
  late List<_Restaurants> yearlydata = [];
  static const keyMonth = 'key-month';
  static const keyYear = 'key-year';
  late String month_name = translate('stats_page.months.Jan');
  late int month = 1;
  late int year = 2020;

  Future<void> monthlyRate(List<_Restaurants>? data) async {
    monthlydata.clear();
    for (_Restaurants rest in data!) {
      if (rest.restMonth == month && rest.restYear == year) {
        monthlydata.add(rest);
      }
    }
  }

  Future<void> yearlyRate(List<_Restaurants>? data) async {
    yearlydata.clear();
    for (Restaurant restaurant in listRestaurants!) {
      for (_Restaurants rest in data!) {
        if (rest.restName == restaurant.restaurantName && rest.restYear == year) {
          if (yearlydata.isEmpty) {
            yearlydata.add(rest);
          }
          else {
            if (rest.restName == yearlydata.last.restName){
              var occ = yearlydata.last.restCustomers + rest.restCustomers;
              var rate = rest.restRate;
              _Restaurants newRest =  _Restaurants(rest.restName, rest.restMonth, rest.restYear, rate, occ);
              yearlydata.removeLast();
              yearlydata.add(newRest);
            }
            else {
              yearlydata.add(rest);
            }
          }
        }
      }
    }
  }

  Future<void> getRestaurants() async {
    listRestaurants = await restaurantService.getRestaurantByOwner(widget.owner!.id);
    for (Restaurant rest in listRestaurants!) {
      for (var stat in rest.statsLog) {
        if (dataRestaurants!.isEmpty) {
          _Restaurants newRest =  _Restaurants(rest.restaurantName, DateTime.parse(stat['date']).month, DateTime.parse(stat['date']).year, stat['rating'].toDouble(), stat['occupation'].toDouble());
          dataRestaurants?.add(newRest);
        }
        else {
          if (DateTime.parse(stat['date']).month == dataRestaurants!.last.restMonth && DateTime.parse(stat['date']).year == dataRestaurants!.last.restYear) {
            dataRestaurants!.last.restCustomers += stat['occupation'];
            dataRestaurants!.last.restRate = stat['rating'];
          }
          else {
            _Restaurants newRest =  _Restaurants(rest.restaurantName, DateTime.parse(stat['date']).month, DateTime.parse(stat['date']).year, stat['rating'].toDouble(), stat['occupation'].toDouble());
            dataRestaurants?.add(newRest);
          }
        }
      }
    }
  }

  @override
  void initState() {
    getRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate('stats_page.title')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                      text: translate('rating') + ': ' + month_name + ', ' +  year.toString(),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_Restaurants, String>>[
                      BarSeries<_Restaurants, String>(
                        dataSource: monthlydata,
                        xValueMapper: (_Restaurants rest, _) => rest.restName,
                        yValueMapper: (_Restaurants rest, _) => rest.restRate,
                        name: translate('rating'),
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
                      text: translate('rating') + ': ' +  year.toString(),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_Restaurants, String>>[
                      BarSeries<_Restaurants, String>(
                        dataSource: yearlydata,
                        xValueMapper: (_Restaurants rest, _) => rest.restName,
                        yValueMapper: (_Restaurants rest, _) => rest.restRate,
                        name: translate('rating'),
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
                      text: translate('occupation') + ': ' + month_name + ', ' +  year.toString(),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_Restaurants, String>>[
                      BarSeries<_Restaurants, String>(
                        dataSource: monthlydata,
                        xValueMapper: (_Restaurants rest, _) => rest.restName,
                        yValueMapper: (_Restaurants rest, _) => rest.restCustomers,
                        name: translate('occupation'),
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
                      text: translate('occupation') + ': ' +  year.toString(),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_Restaurants, String>>[
                      BarSeries<_Restaurants, String>(
                        dataSource: yearlydata,
                        xValueMapper: (_Restaurants rest, _) => rest.restName,
                        yValueMapper: (_Restaurants rest, _) => rest.restCustomers,
                        name: translate('occupation'),
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }

  Widget buildMonth({required BuildContext context}) => DropDownSettingsTile(
    settingKey: keyMonth,
    title: translate('stats_page.month'),
    selected: 1,
    values: <int, String> {
      1: translate('stats_page.months_ab.Jan'),
      2: translate('stats_page.months_ab.Feb'),
      3: translate('stats_page.months_ab.Mar'),
      4: translate('stats_page.months_ab.Apr'),
      5: translate('stats_page.months_ab.May'),
      6: translate('stats_page.months_ab.Jun'),
      7: translate('stats_page.months_ab.Jul'),
      8: translate('stats_page.months_ab.Aug'),
      9: translate('stats_page.months_ab.Sep'),
      10: translate('stats_page.months_ab.Oct'),
      11: translate('stats_page.months_ab.Nov'),
      12: translate('stats_page.months_ab.Dec')
    },
    onChange: (month) {
      if(month == 1) {
        this.month = 1; 
        month_name = translate('stats_page.months.Jan');
      }
      if(month == 2) {
        this.month = 2;
        month_name = translate('stats_page.months.Feb');
      }
      if(month == 3) {
        this.month = 3;
        month_name = translate('stats_page.months.Mar');
      }
      if(month == 4) {
        this.month = 4;
        month_name = translate('stats_page.months.Apr');
      }
      if(month == 5) {
        this.month = 5;
        month_name = translate('stats_page.months.May');
      }
      if(month == 6) {
        this.month = 6;
        month_name = translate('stats_page.months.Jun');
      }
      if(month == 7) {
        this.month = 7;
        month_name = translate('stats_page.months.Jul');
      }
      if(month == 8) {
        this.month = 8;
        month_name = translate('stats_page.months.Aug');
      }
      if(month == 9) {
        this.month = 9;
        month_name = translate('stats_page.months.Sep');
      }
      if(month == 10) {
        this.month = 10;
        month_name = translate('stats_page.months.Oct');
      }
      if(month == 11) {
        this.month = 11;
        month_name = translate('stats_page.months.Nov');
      }
      if(month == 12) {
        this.month = 12;
        month_name = translate('stats_page.months.Dec');
      }
      monthlyRate(dataRestaurants);
      setState(() {
        
      });
    },
  );

  Widget buildYear({required BuildContext context}) => DropDownSettingsTile(
    settingKey: keyYear,
    title: translate('stats_page.year'),
    selected: 1,
    values: const <int, String> {
      1: "2020",
      2: "2021",
      3: "2022",
    },
    onChange: (year) {
      if(year == 1) this.year = 2020;
      if(year == 2) this.year = 2021;
      if(year == 3) this.year = 2022;
      monthlyRate(dataRestaurants);
      yearlyRate(dataRestaurants);
      setState(() {
  
      });
    },
  );
}

class _Restaurants {
  _Restaurants(this.restName, this.restMonth, this.restYear, this.restRate, this.restCustomers);

  final String restName;
  final int restMonth;
  final int restYear;
  late double restRate;
  late double restCustomers;
}
