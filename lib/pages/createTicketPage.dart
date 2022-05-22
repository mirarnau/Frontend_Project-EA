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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 43, 43)
      ),
      body: Container(
        color: const Color.fromARGB(255, 30, 30, 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: restaurantController,
                style: const TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                decoration: const InputDecoration(
                  hintText: 'Write to restaurant',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97)
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: subjectController,
                style: const TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                decoration: const InputDecoration(
                  hintText: 'Subject',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97)
                  )
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: messageController,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Write the details of the incidence here',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 97, 97)
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
              child: const Icon(
                Icons.send,
                color: Color.fromARGB(255, 213, 94, 85),
              ),
              backgroundColor: const Color.fromARGB(255, 60, 60, 60),
              onPressed: () async {
                Message newMessage = Message(senderName: widget.myCustomer!.customerName, 
                        receiverName: restaurantController.text, 
                        message: messageController.text, 
                        profilePicSender: widget.myCustomer!.profilePic);

                List <Message> newListMessages = [];
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
              },
            ),
          ),
        ) ,
    );
  }
}
  
