import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/message.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/reservation.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/ticketsPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/services/reservationService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:flutter_tutorial/widgets/lateralChatWidget.dart';
import 'package:flutter_tutorial/widgets/ticketWidget.dart';
import 'package:flutter_tutorial/services/ticketsService.dart';

class CreateRestaurantPage extends StatefulWidget {
  final Customer? myCustomer;
  const CreateRestaurantPage({Key? key, required this.myCustomer})
      : super(key: key);

  @override
  State<CreateRestaurantPage> createState() => _CreateRestaurantPageState();
}

class _CreateRestaurantPageState extends State<CreateRestaurantPage> {
  TicketService ticketService = TicketService();
  List<Ticket>? listTickets;
  bool isLoading = true;

  final restaurantController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  CustomerService customerService = CustomerService();
  OwnerService ownerService = OwnerService();
  RestaurantService restaurantService = RestaurantService();
  ReservationApi reservationApi = ReservationApi();

  Customer? customer;
  Owner? owner;
  Restaurant? restaurant;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    restaurantController.dispose();
    dateController.dispose();
    timeController.dispose();

    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Empty fields",
        style: TextStyle(color: Colors.red),
      ),
      content: Text('Some fields are empty, please fill them'),
      actions: [
        okButton,
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: Container(
        color: Theme.of(context).canvasColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: dateController,
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                  maxLines: 1,
                  expands: false,
                  decoration: InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      hintStyle:
                          TextStyle(color: Theme.of(context).shadowColor)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: timeController,
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                  maxLines: 1,
                  expands: false,
                  decoration: InputDecoration(
                      hintText: 'HH:MM',
                      hintStyle:
                          TextStyle(color: Theme.of(context).shadowColor)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: restaurantController,
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                  maxLines: 1,
                  expands: false,
                  decoration: InputDecoration(
                      hintText: 'Restaurant',
                      hintStyle:
                          TextStyle(color: Theme.of(context).shadowColor)),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        height: 200.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              Icons.send,
              color: Theme.of(context).focusColor,
            ),
            backgroundColor: Theme.of(context).cardColor,
            onPressed: () async {
              if (dateController.text.isNotEmpty &&
                  restaurantController.text.isNotEmpty &&
                  timeController.text.isNotEmpty) {
                Reservation newReservation = Reservation(
                  idCustomer: widget.myCustomer!.id,
                  restaurantName: restaurantController.text,
                  dateReservation: dateController.text,
                  timeReservation: timeController.text,
                );

                Reservation? reservationAdded =
                    await reservationApi.addReservation(newReservation);
                //print(reservationAdded!.restaurantName);

                List<String> voidListTags = [];
                var route = MaterialPageRoute(
                    builder: (BuildContext context) => MainPage(
                          customer: widget.myCustomer,
                          selectedIndex: 2,
                          transferRestaurantTags: voidListTags,
                          chatPage: "Inbox",
                        ));

                Navigator.of(context).push(route);
              } else {
                showAlertDialog(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
