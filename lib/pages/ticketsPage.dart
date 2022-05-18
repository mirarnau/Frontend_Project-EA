import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/lateralChatWidget.dart';
import 'package:flutter_tutorial/widgets/ticketWidget.dart';
import 'package:flutter_tutorial/widgets/lateralRestaurantWidget.dart';
import 'package:flutter_tutorial/services/ticketsService.dart';
import 'mainPage.dart';


class TicketsPage extends StatefulWidget {
  final String userType; 
  final String myName;
  const TicketsPage({Key? key, required this.userType, required this.myName}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  TicketService ticketService = TicketService();
  List<Ticket>? listTickets;
  bool isLoading = true;

  CustomerService customerService = CustomerService();
  OwnerService ownerService = OwnerService();

  Customer? customer;
  Owner? owner;

  @override
  void initState() {
    super.initState();
    if (widget.userType == "Customer"){
      getInfoCustomer();
    }
    if (widget.userType == "Owner"){
      getInfoOwner();
    }
    getTicketsByCreator();
  }

  Future<void> getInfoCustomer() async{
    customer = await customerService.getCustomerByName(widget.myName);
  } 

  Future<void> getInfoOwner() async{
    owner = await ownerService.getOwnerByName(widget.myName);
  } 

  Future<void> getTicketsByCreator() async {
    listTickets = await ticketService.getTicketsByCreator(widget.myName);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getTicketsByRecipient() async {
    listTickets = await ticketService.getTicketsByRecipient(widget.myName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listTickets == null){
      return  Scaffold(
        body: const Text('No tickets'),
        floatingActionButton: Container(
          alignment: Alignment.bottomRight,
          height: 200.0,
          width: 100.0,
          child: FittedBox(
            child: FloatingActionButton.extended(
              backgroundColor: Color.fromARGB(255, 60, 60, 60),
              icon: const Icon(
                Icons.add_comment,
                color: Color.fromARGB(255, 213, 94, 85)),
              label: const Text(
                'Create',
                style: TextStyle(
                  color: Color.fromARGB(255, 213, 94, 85)
                ),
              ),
              onPressed: () {},
            ),
          ),
        ) ,
      );
    }
    return Scaffold(
        appBar: AppBar(
        ),
        drawer: NavDrawerChat(),
        body: Container(
          color: Color.fromARGB(255, 30, 30, 30),
          child: Column (
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            Expanded(
              child: 
              ListView.builder(
                shrinkWrap: true,
                itemCount: listTickets?.length,
                itemBuilder: (context, index) {
                  return TicketWidget (
                      creatorName: listTickets![index].creatorName,
                      subject: listTickets![index].subject,
                      message: listTickets![index].message,
                      status: listTickets![index].status.toString(),
                      imageURL: listTickets![index].profilePicCreator,);
                }
              )
            ),
          ],
        ),
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomRight,
          height: 200.0,
          width: 100.0,
          child: FittedBox(
            child: FloatingActionButton.extended(
              backgroundColor: Color.fromARGB(255, 60, 60, 60),
              icon: const Icon(
                Icons.add_comment,
                color: Color.fromARGB(255, 213, 94, 85)),
              label: const Text(
                'Create',
                style: TextStyle(
                  color: Color.fromARGB(255, 213, 94, 85)
                ),
              ),
              onPressed: () {},
            ),
          ),
        ) ,
    );
  }
}
  
