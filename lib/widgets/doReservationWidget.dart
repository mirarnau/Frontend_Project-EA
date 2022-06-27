import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/reservation.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/reservationService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/customer.dart';

class DoReservationWidget extends StatefulWidget {
  final Customer? customer;
  final Restaurant? restaurant;
  const DoReservationWidget({Key? key, required this.customer, required this.restaurant}) : super(key: key);

  @override
  State<DoReservationWidget> createState() => _DoReservationWidgetState();
}

class _DoReservationWidgetState extends State<DoReservationWidget> {
  RestaurantService _restaurantService = new RestaurantService();
  CustomerService _customerService = new CustomerService();
  ReservationService _reservationService = new ReservationService();

  late final Restaurant? _restaurant;
  late final Customer? _customer;
  bool _isDisabled = false;

  String? _numInitial;
  String? _phoneInitial; 
  late TextEditingController _numController;
  late TextEditingController _phoneController;
  
  late DateTime _hourTime = DateTime.now();
  late DateTime _dayTime = DateTime.now();
  late int _numCustomers;
  late String _phoneRes;


  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _dayTime = args.value;
      }
    });
  }

  @override
  void initState() {
    _customer = widget.customer;
    _restaurant = widget.restaurant;
    _numInitial = "";
    _phoneInitial = "";
    _numController = TextEditingController(text: _numInitial);
    _phoneController = TextEditingController(text: _phoneInitial);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            height: 600,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildReservationText(),
              ],
            ),
          ),
          Positioned( 
            bottom: 50,
            left: 20,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.7,
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                minDate: DateTime.now(),
              ),
            ),
          ),
          Positioned( 
            bottom: 375,
            left: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                timePicker(),
                const SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(
                      width: 140,
                      height: 50,
                      child: TextField(
                        controller: _numController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: translate('restaurants_page.num'),
                          hintText: translate('restaurants_page.num')),
                        onChanged: (val) {
                          _numCustomers = int.parse(val);;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 140,
                      height: 50,
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: translate('restaurants_page.phone'),
                          hintText: translate('restaurants_page.phone')),
                        onChanged: (val) {
                          _phoneRes = val;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: MediaQuery.of(context).size.width * 0.4,
            child: Container(
              color: Colors.grey,
              child: MaterialButton(
              onPressed:() {
                _hideDialog();
              }, 
              child: Text(translate('skip')),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: MaterialButton(
                onPressed: _isDisabled ? null : () async {
                  if (_numController.text.isNotEmpty &&
                  _phoneController.text.isNotEmpty) {

                  String _selectedTime;
                  String _selectedDay;

                  String hour = _hourTime.hour.toString();
                  String minute = _hourTime.minute.toString();
                  String day = _dayTime.day.toString();
                  String month = _dayTime.month.toString();
                  String year = _dayTime.year.toString();

                  _selectedTime = "$hour:$minute";
                  _selectedDay = "$day/$month/$year";

                  Reservation newReservation = Reservation(
                    idCustomer: _customer!.id,
                    idRestaurant: _restaurant!.id,
                    dateReservation: _selectedDay,
                    timeReservation: _selectedTime,
                    numCustomers: _numCustomers,
                    phone: _phoneRes, 
                    nameCustomer: _customer!.fullName,
                    nameRestaurant: _restaurant!.restaurantName
                  );
                  
                  await _reservationService.addReservation(newReservation);
                  
                  _hideDialog();
                } 
                else {
                  return;
                }
                }, 
                child: Text(translate('done')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildReservationText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 40),
        Text(
          'Thanks for visiting our Restaurant',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'Make your reservation here:'
        )
      ],
    );
  }

  _hideDialog() {
    if(Navigator.canPop(context)) Navigator.pop(context);
  }

  Widget timePicker() {
    return TimePickerSpinner(
      time: DateTime.now(),
      minutesInterval: 15,
      normalTextStyle: TextStyle(
        fontSize: 18,
        color: Theme.of(context).highlightColor,
      ),
      highlightedTextStyle: TextStyle(
        fontSize: 24,
        color: Theme.of(context).primaryColor,
      ),
      alignment: Alignment.center,
      spacing: 15,
      itemHeight: 40,
      onTimeChange: (time) {
        _hourTime = time;
      },
    );
  }
}