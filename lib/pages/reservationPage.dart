import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/reservation.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/pages/createTicketPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/services/reservationService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:flutter_tutorial/widgets/loadingCardsWidget.dart';
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
  ReservationService _reservationService = ReservationService();
  List<Reservation>? listReservations;
  CustomerService customerService = CustomerService();
  RestaurantService restaurantService = RestaurantService();
  OwnerService ownerService = OwnerService();
  Customer? customer;
  Restaurant? restaurant;
  Owner? owner;

  bool _isLoading = true;
  bool _isEmpty = true;

  @override
  void initState() {
    
    Future.delayed(const Duration(seconds: 1), () {

      if (widget.userType == "Customer") {
        getInfoCustomer();
      }
      if (widget.userType == "Owner") {
        getInfoOwner();
      }

      getAllReservations();

    });

    super.initState();
  }

  Future<void> getInfoCustomer() async {
    customer = await customerService.getCustomerByName(widget.myName);
  }

  Future<void> getInfoOwner() async {
    owner = await ownerService.getOwnerByName(widget.myName);
  }

  Future<void> getReservationsById() async {
    listReservations = await _reservationService.getReservationById(widget.myCustomer!.id);
  }

  Future<void> getAllReservations() async {
      
    setState(() => _isLoading = true);

    listReservations = await _reservationService.getAllReservations();

    if(listReservations!.isEmpty) {
      _isEmpty = true;
    }
    else {
      _isEmpty = false;
    }

    setState(() => _isLoading = false);

  }

  bool isThisCustomer(int index) {
    if (listReservations![index].idCustomer != widget.myCustomer!.id) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).cardColor,
        title: const Text ("Your reservations"),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _isLoading
            ? Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => const LoadingCards(),
                itemCount: 8
              ),
            )
            : _isEmpty
              ? Text(
                  "There are no reservations",
                  style: TextStyle(
                    color: Theme.of(context).highlightColor
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listReservations?.length,
                    itemBuilder: (context, index) {
                      if (listReservations![index].idCustomer ==
                          widget.myCustomer!.id) {
                        return GestureDetector(
                          child: ReservationWidget(
                            dateDay: listReservations![index].dateReservation,
                            dateTime: listReservations![index].timeReservation,
                            nameRest: listReservations![index].nameRestaurant, 
                            nameCust: listReservations![index].nameCustomer,
                            phone: listReservations![index].phone,
                          ),
                        );
                      } else {
                        return GestureDetector(child: Text(''));
                      }
                    }
                  ),
              ),
          ],
        ),
      ),
    );
  }
}
