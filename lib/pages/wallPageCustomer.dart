// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/message.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/chatPage.dart';
import 'package:flutter_tutorial/pages/createTicketPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/lateralChatWidget.dart';
import 'package:flutter_tutorial/widgets/ticketWidget.dart';
import 'package:flutter_tutorial/services/ticketsService.dart';


class WallPageCustomer extends StatefulWidget {
  final Customer? myCustomer;
  final String userType; 
  const WallPageCustomer({Key? key, required this.userType,required this.myCustomer}) : super(key: key);

  @override
  State<WallPageCustomer> createState() => _WallPageCustomerState();
}

class _WallPageCustomerState extends State<WallPageCustomer> {
  TicketService ticketService = TicketService();
  List<Ticket>? listTicketsReceived;
  List<Ticket>? listTicketsSent;
  bool isLoading = true;

  CustomerService customerService = CustomerService();
  OwnerService ownerService = OwnerService();

  Customer? customer;
  Owner? owner;

  @override
  void initState() {
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Wall'),
      )
    );
  }
    
  
}
  
