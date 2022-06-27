import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/reservation.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/services/reservationService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:flutter_tutorial/widgets/loadingCardsWidget.dart';
import 'package:flutter_tutorial/widgets/reservationWidget.dart';

class OwnerReservationPage extends StatefulWidget {
  final Restaurant? selectedRestaurant;
  final Owner? owner;
  const OwnerReservationPage(
      {Key? key, required this.selectedRestaurant, required this.owner})
      : super(key: key);

  @override
  State<OwnerReservationPage> createState() => _OwnerReservationPageState();
}

class _OwnerReservationPageState extends State<OwnerReservationPage> {
  ReservationService _reservationService = ReservationService();
  List<Reservation>? listReservations;
  OwnerService _ownerService = OwnerService();
  RestaurantService restaurantService = RestaurantService();
  OwnerService ownerService = OwnerService();
  Restaurant? restaurant;
  Owner? _owner;

  bool _isLoading = true;
  bool _isEmpty = true;
  bool _isReload = false;

  @override
  void initState() {

    _owner = widget.owner;

    Future.delayed(const Duration(seconds: 2), () {

      getAllReservations();

    });

    super.initState();
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

    _isReload = false;

    setState(() => _isLoading = false);

  }

  @override
  Widget build(BuildContext context) {
    if(_isReload) getAllReservations();

    return Scaffold(
      appBar: AppBar(
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
                      if (listReservations![index].idRestaurant ==
                          widget.selectedRestaurant!.id) {
                        return GestureDetector(
                            child: ReservationWidget(
                            dateDay: listReservations![index].dateReservation,
                            dateTime: listReservations![index].timeReservation,
                            nameRest: listReservations![index].nameRestaurant, 
                            nameCust: listReservations![index].nameCustomer,
                            phone: listReservations![index].phone,
                          ),
                          onTap: () async { 
                            await _reservationService.deleteReservation(listReservations![index].id);
                            setState(() {
                              _isReload = true;
                            });
                          }
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
