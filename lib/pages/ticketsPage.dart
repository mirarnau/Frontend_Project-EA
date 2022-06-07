// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/message.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/chatBotPage.dart';
import 'package:flutter_tutorial/pages/chatPage.dart';
import 'package:flutter_tutorial/pages/createTicketPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/lateralChatWidget.dart';
import 'package:flutter_tutorial/widgets/ticketWidget.dart';
import 'package:flutter_tutorial/services/ticketsService.dart';


class TicketsPage extends StatefulWidget {
  final Customer? myCustomer;
  final String userType; 
  final String myName;
  final String page;
  const TicketsPage({Key? key, required this.userType, required this.myName, required this.myCustomer, required this.page}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
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
    listTicketsSent = await ticketService.getTicketsByCreator(widget.myName);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getTicketsByRecipient() async {
    listTicketsReceived = await ticketService.getTicketsByRecipient(widget.myName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (widget.page == "Sent"){
      if (listTicketsSent == null){
        return  Container(
          color: Theme.of(context).canvasColor,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              title: Text(
                widget.page,
                style: TextStyle(
                  color: Colors.white
                ),),
            ),
            drawer: NavDrawerChat(myCustomer: widget.myCustomer,currentPage: "Sent",),
            body: Text(translate('tickets_page.no_tickets')),
            floatingActionButton: Container(
              alignment: Alignment.bottomRight,
              height: 200.0,
              width: 100.0,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  backgroundColor: Theme.of(context).cardColor,
                  icon: Icon(
                    Icons.add_comment,
                    color: Theme.of(context).focusColor),
                  label: Text(
                    translate('tickets_page.create'),
                    style: TextStyle(
                      color: Theme.of(context).focusColor
                    ),
                  ),
                  onPressed: () {
                  var routes = MaterialPageRoute(
                        builder: (BuildContext context) => 
                          CreateTicketPage(myCustomer: widget.myCustomer)
                      );
                      Navigator.of(context).push(routes);
                },
                ),
              ),
            ) ,
          ),
        );
      }
      else{
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              title: Text(
                widget.page,
                style: TextStyle(
                  color: Colors.white
                ),),
            ),
          drawer: NavDrawerChat(myCustomer: widget.myCustomer,currentPage: "Sent",),
          body: Container(
            color: Theme.of(context).canvasColor,
            child: Column (
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              Expanded(
                child: 
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listTicketsSent?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        List<MessageCustom>? listMessagesTicket = await ticketService.getMessagesFromTicket(listTicketsSent![index]);
                        
                        var routes = MaterialPageRoute(
                        builder: (BuildContext context) => 
                          ChatPage(myCustomer: widget.myCustomer, selectedTicket: listTicketsSent![index], listMessages: listMessagesTicket,)
                      );
                      Navigator.of(context).push(routes);
                      },
                      child: TicketWidget (
                        creatorName: listTicketsSent![index].creatorName,
                        subject: listTicketsSent![index].subject,
                        status: listTicketsSent![index].status.toString()),
                    );
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
                backgroundColor: Theme.of(context).cardColor,
                icon: Icon(
                  Icons.add_comment,
                  color: Theme.of(context).focusColor),
                label: Text(
                  translate('tickets_page.create'),
                  style: TextStyle(
                    color: Theme.of(context).focusColor
                  ),
                ),
                onPressed: () {
                  var routes = MaterialPageRoute(
                        builder: (BuildContext context) => 
                          CreateTicketPage(myCustomer: widget.myCustomer)
                      );
                      Navigator.of(context).push(routes);
                },
              ),
            ),
          ) ,
      );
    }
    }
    else{ 
      if (listTicketsReceived == null){
        return  Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              title: Text(
                widget.page,
                style: TextStyle(
                  color: Colors.white
                ),),
            ),
          drawer: NavDrawerChat(myCustomer: widget.myCustomer,currentPage: "Inbox",),
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
                  color: Colors.white
                ),),
            )),
            floatingActionButton: 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    alignment: Alignment.bottomLeft,
                    height: 200.0,
                    width: 100.0,
                    child: FittedBox(
                      child: FloatingActionButton.extended(
                        heroTag: "1",
                        backgroundColor: Theme.of(context).cardColor,
                        icon: Icon(
                          Icons.add_comment,
                          color: Colors.blue),
                        label: Text(
                          'Chat Bot',
                          style: TextStyle(
                            color: Colors.blue
                          ),
                        ),
                        onPressed: () {
                          var routes = MaterialPageRoute(
                                builder: (BuildContext context) => 
                                  ChatBotPage()
                              );
                              Navigator.of(context).push(routes);
                        },
                      ),
                    ),
                  ),
                Container(
                alignment: Alignment.bottomRight,
                height: 200.0,
                width: 100.0,
                child: FittedBox(
                  child: FloatingActionButton.extended(
                    heroTag: '2',
                    backgroundColor: Theme.of(context).cardColor,
                    icon: Icon(
                      Icons.add_comment,
                      color: Theme.of(context).focusColor),
                    label: Text(
                      translate('tickets_page.create'),
                      style: TextStyle(
                        color: Theme.of(context).focusColor
                      ),
                    ),
                    onPressed: () {
                      var routes = MaterialPageRoute(
                            builder: (BuildContext context) => 
                              CreateTicketPage(myCustomer: widget.myCustomer)
                          );
                          Navigator.of(context).push(routes);
                    },
                  ),
                ),
              ),
            ]
          ) ,
        );
      }
      return Scaffold(
          appBar: AppBar(
          ),
          drawer: NavDrawerChat(myCustomer: widget.myCustomer, currentPage: "Inbox",),
          body: Container(
            color: Color.fromARGB(255, 30, 30, 30),
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
                          ChatPage(myCustomer: widget.myCustomer, selectedTicket: listTicketsReceived![index], listMessages: listMessages,)
                      );
                      Navigator.of(context).push(routes);
                      },
                      child: TicketWidget (
                        creatorName: listTicketsReceived![index].creatorName,
                        subject: listTicketsReceived![index].subject,
                        status: listTicketsReceived![index].status.toString())
                    );
                  }
                )
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    height: 200.0,
                    width: 100.0,
                    child: FittedBox(
                      child: FloatingActionButton.extended(
                        heroTag: '1',
                        backgroundColor: Theme.of(context).cardColor,
                        icon: Icon(
                          Icons.add_comment,
                          color: Theme.of(context).focusColor),
                        label: Text(
                          'Create',
                          style: TextStyle(
                            color: Theme.of(context).focusColor
                          ),
                        ),
                        onPressed: () {
                          var routes = MaterialPageRoute(
                                builder: (BuildContext context) => 
                                  CreateTicketPage(myCustomer: widget.myCustomer)
                              );
                              Navigator.of(context).push(routes);
                        },
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 200.0,
                    width: 100.0,
                    child: FittedBox(
                      child: FloatingActionButton.extended(
                        heroTag: '2',
                        backgroundColor: Theme.of(context).cardColor,
                        icon: Icon(
                          Icons.add_comment,
                          color: Theme.of(context).focusColor),
                        label: Text(
                          'Create',
                          style: TextStyle(
                            color: Theme.of(context).focusColor
                          ),
                        ),
                        onPressed: () {
                          var routes = MaterialPageRoute(
                                builder: (BuildContext context) => 
                                  CreateTicketPage(myCustomer: widget.myCustomer)
                              );
                              Navigator.of(context).push(routes);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          ),
          
      );
    }
    
  }
}
  
