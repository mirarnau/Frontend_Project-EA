import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/reservation.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/services/reservationService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:flutter_tutorial/widgets/reservationWidget.dart';

class OwnerReservationPage extends StatefulWidget {
  final Restaurant? selectedRestaurant;
  final Owner? customer;
  const OwnerReservationPage(
      {Key? key, required this.selectedRestaurant, required this.customer})
      : super(key: key);

  @override
  State<OwnerReservationPage> createState() => _OwnerReservationPageState();
}

class _OwnerReservationPageState extends State<OwnerReservationPage> {
  ReservationService _reservationService = ReservationService();
  List<Reservation>? listReservations;
  CustomerService customerService = CustomerService();
  RestaurantService restaurantService = RestaurantService();
  bool isLoading = true;
  OwnerService ownerService = OwnerService();
  Customer? customer;
  Restaurant? restaurant;
  Owner? owner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfoCustomer();
    getAllReservations();
  }

  Future<void> getInfoCustomer() async {
    customer =
        await customerService.getCustomerByName(widget.customer!.ownerName);
  }

  Future<void> getAllReservations() async {
    listReservations = await _reservationService.getAllReservations();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listReservations == null) {
      return Container(
          color: Theme.of(context).canvasColor,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              title: Text(''),
            ),
            body: Text(''),
          ));
    } else {
      if (listReservations == null) {
        return Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              )),
        );
      }
      return Scaffold(
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listReservations?.length,
                      itemBuilder: (context, index) {
                        if (listReservations![index].restaurantName ==
                            widget.selectedRestaurant!.restaurantName) {
                          return GestureDetector(
                              child: ReservationWidget(
                                  creatorName:
                                      listReservations![index].dateReservation,
                                  subject:
                                      listReservations![index].timeReservation,
                                  status:
                                      listReservations![index].restaurantName));
                        } else {
                          return GestureDetector(child: Text(''));
                        }
                      })),
            ],
          ),
        ),
      );
    }
  }
}
