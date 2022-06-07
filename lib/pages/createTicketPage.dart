// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/message.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/ticketsPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/lateralChatWidget.dart';
import 'package:flutter_tutorial/widgets/ticketWidget.dart';
import 'package:flutter_tutorial/services/ticketsService.dart';


class CreateTicketPage extends StatefulWidget {
  final Customer? myCustomer;
  const CreateTicketPage({Key? key, required this.myCustomer}) : super(key: key);

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  TicketService ticketService = TicketService();
  List<Ticket>? listTickets;
  bool isLoading = true;

  final restaurantController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  CustomerService customerService = CustomerService();
  OwnerService ownerService = OwnerService();

  Customer? customer;
  Owner? owner;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    restaurantController.dispose();
    subjectController.dispose();
    messageController.dispose();

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: restaurantController,
                style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                decoration: InputDecoration(
                  hintText: 'Write to restaurant',
                  hintStyle: TextStyle(
                    color: Theme.of(context).shadowColor
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: subjectController,
                style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                decoration: InputDecoration(
                  hintText: 'Subject',
                  hintStyle: TextStyle(
                    color: Theme.of(context).shadowColor
                  )
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: messageController,
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'Write the details of the incidence here',
                    hintStyle: TextStyle(
                      color: Theme.of(context).shadowColor
                    )
                  ),
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

                if (subjectController.text.isNotEmpty && restaurantController.text.isNotEmpty && messageController.text.isNotEmpty){
                  MessageCustom newMessage = MessageCustom(senderName: widget.myCustomer!.customerName, 
                        receiverName: restaurantController.text, 
                        message: messageController.text, 
                        profilePicSender: widget.myCustomer!.profilePic);

                List <MessageCustom> newListMessages = [];
                newListMessages.add(newMessage);
                
                Ticket newTicket = Ticket(creatorName: widget.myCustomer!.customerName, 
                        recipientName: restaurantController.text, 
                        subject: subjectController.text);

                Ticket? ticketAdded = await ticketService.addTicket(newTicket) ;
                print(ticketAdded!.id);
                ticketService.addMessageToTicket(newMessage, ticketAdded);

                List<String> voidListTags = [];
                var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainPage(customer: widget.myCustomer, selectedIndex: 1, transferRestaurantTags: voidListTags, chatPage: "Inbox",));
                    
                Navigator.of(context).push(route);
                }

                else{
                  showAlertDialog(context);
                }
                
              },
            ),
          ),
        ) ,
    );
  }
}
  
