import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/reservation.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/reservationService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:flutter_tutorial/widgets/reservationWidget.dart';
import 'package:provider/provider.dart';

class ReservationPage extends StatefulWidget {
  final Customer? myCustomer;
  final String myName;
  final String userType;
  const ReservationPage(
      {Key? key,
      required this.myCustomer,
      required this.myName,
      required this.userType})
      : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  ReservationApi reservationApi = ReservationApi();
  List<Reservation>? listReservations;
  CustomerService customerService = CustomerService();
  RestaurantService restaurantService = RestaurantService();
  bool isLoading = true;
  Customer? customer;
  Restaurant? restaurant;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userType == "Customer") {
      getInfoCustomer();
    }
    //getReservationsById();
    getAllReservations();
  }

  Future<void> getInfoCustomer() async {
    customer = await customerService.getCustomerByName(widget.myName);
  }

  Future<void> getReservationsById() async {
    listReservations =
        await reservationApi.getReservationById(widget.myCustomer!.id);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getAllReservations() async {
    listReservations = await reservationApi.getAllReservations();
    setState(() {
      isLoading = false;
    });
  }

  bool isThisCustomer(int index) {
    if (listReservations![index].idCustomer != widget.myCustomer!.id) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (listReservations == null) {
      return Container(
          color: Theme.of(context).canvasColor,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              title: Text('null'),
            ),
            body: Text('null'),
          ));
    } else {
      if (listReservations == null) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            title: Text(''),
          ),
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
        appBar: AppBar(),
        body: Container(
          color: Color.fromARGB(255, 30, 30, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listReservations?.length,
                      itemBuilder: (context, index) {
                        if (listReservations![index].idCustomer ==
                            widget.myCustomer!.id) {
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
