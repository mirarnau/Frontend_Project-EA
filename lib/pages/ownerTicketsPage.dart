// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/message.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/ownerChatPage.dart';
import 'package:flutter_tutorial/pages/createTicketPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/ownerLateralChatWidget.dart';
import 'package:flutter_tutorial/widgets/ticketWidget.dart';
import 'package:flutter_tutorial/services/ticketsService.dart';

import '../models/restaurant.dart';
import '../services/restaurantService.dart';
import '../widgets/ownerTicketWidget.dart';
import 'indexPage.dart';


class OwnerTicketsPage extends StatefulWidget {
  final myOwner;
  final String myName;
  final String page;
  const OwnerTicketsPage({Key? key, required this.myName, required this.myOwner, required this.page}) : super(key: key);

  @override
  State<OwnerTicketsPage> createState() => _OwnerTicketsPageState();
}

class _OwnerTicketsPageState extends State<OwnerTicketsPage> {
  TicketService ticketService = TicketService();
  List<Ticket>? listTicketsReceived = [];
  List<Ticket>? listTicketsReceivedA = [];
  List<Ticket>? listTicketsReceivedB = [];
  List<Ticket>? listTicketsSent;
  List<Restaurant>? listRest = [];
  bool isLoading = true;
  late var myOwner = widget.myOwner;

  OwnerService ownerService = OwnerService(); 
  RestaurantService restaurantService = RestaurantService();

  Owner? owner;

  @override
  void initState() {
    getInfoOwner();
    getTicketsByRecipient();
  }

  Future<void> getInfoOwner() async{
    owner = await ownerService.getOwnerByName(widget.myName);
    listRest = await restaurantService.getRestaurantByOwner(owner!.id);

    if(listRest != null) {
      for (int i = 0; i < listRest!.length; i++){
        listTicketsReceivedA = await ticketService.getTicketsByRecipient(listRest![i].restaurantName.toString());
        for (int j = 0; j < listTicketsReceivedA!.length; j++){
          listTicketsReceivedB!.add(listTicketsReceivedA![j]);
        }
      }
      listTicketsReceived = listTicketsReceivedB; 
    }
    else {
      listTicketsReceived = null;
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getTicketsByRecipient() async {
    
    
  }

  @override
  Widget build(BuildContext context) {
    if (listTicketsReceived == null){
      return  Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            title: Text(
              widget.page,
              style: TextStyle(
              color: Color.fromARGB(255, 30, 30, 30),
              ),),
          ),
        drawer: OwnerNavDrawerChat(myOwner: widget.myOwner, currentPage: "Inbox",),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Text(
              translate('tickets_page.no_tickets'),
              textAlign: TextAlign.center,
              style: TextStyle(
              color: Color.fromARGB(255, 30, 30, 30),
              ),),
          )),
          
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context)=> VideocallPage()
          )
          );
        },
        child: Icon(
          Icons.video_call_outlined,
          color: Theme.of(context).focusColor,
        ),
    ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
        ),
        drawer: OwnerNavDrawerChat(myOwner
    : widget.myOwner
    , currentPage: "Inbox",),
        body: Container(
          child: Column (
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            Expanded(
              child: 
              ListView.builder(
                shrinkWrap: true,
                itemCount: listTicketsReceived?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      List<MessageCustom>? listMessages = await ticketService.getMessagesFromTicket(listTicketsReceived![index]);
                      var routes = MaterialPageRoute(
                      builder: (BuildContext context) => 
                        OwnerChatPage(myOwner
                    : widget.myOwner
                    , selectedTicket: listTicketsReceived![index], listMessages: listMessages,)
                    );
                    Navigator.of(context).push(routes);
                    },
                    child: OwnerTicketWidget (
                      creatorName: listTicketsReceived![index].creatorName,
                      restaurantName: listTicketsReceived![index].recipientName,
                      subject: listTicketsReceived![index].subject,
                      status: listTicketsReceived![index].status.toString())
                  );
                }
              )
            ),
          ],
        ),
        ),
        
    );
  }
}

