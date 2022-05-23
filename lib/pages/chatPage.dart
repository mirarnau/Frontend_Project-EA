// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/message.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/ticket.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/createTicketPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/ticketWidget.dart';
import 'package:flutter_tutorial/services/ticketsService.dart';


class ChatPage extends StatefulWidget {
  final Customer? myCustomer;
  final Ticket selectedTicket;
  final List<Message>? listMessages;
  const ChatPage({Key? key,required this.myCustomer, required this.selectedTicket, required this.listMessages}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TicketService ticketService = TicketService();
  bool isLoading = true;

  String status = "";
  Color colorStatus = Color.fromARGB(255, 110, 187, 90);

  final messageController = TextEditingController();

 @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();

    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    //widget.listMessages!.forEach((element) => print(element.message));
    print (widget.listMessages!.length);

    if (widget.selectedTicket.status == false){
      status = "Opened";
      colorStatus = Color.fromARGB(255, 110, 187, 90);
    }
    if (widget.selectedTicket.status == true){
      status = "Closed";
      colorStatus = Color.fromARGB(255, 179, 33, 35);
    }
  }


  @override
  Widget build(BuildContext context)  {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Color.fromARGB(255, 197, 196, 196),),
                ),
                SizedBox(width: 2),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.selectedTicket.subject,style: TextStyle( 
                        fontSize: 16 ,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 197, 196, 196))),
                      SizedBox(height: 6,),
                      Text(status,style: TextStyle(color: colorStatus, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.settings,color: Color.fromARGB(255, 197, 196, 196),),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 30, 30, 30),
        child: Stack(
          children: <Widget>[
            ListView.builder(
                      itemCount: widget.listMessages!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                              widget.listMessages![index].senderName == widget.myCustomer!.customerName ? 50.0 : 5.0,
                              4,
                              widget.listMessages![index].senderName != widget.myCustomer!.customerName ? 54.0 : 5.0,
                              4
                              ),
                            child: Align(
                              alignment: (widget.listMessages![index].senderName == widget.myCustomer!.customerName ? Alignment.topRight:Alignment.topLeft),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (widget.listMessages![index].senderName  != widget.myCustomer!.customerName ?Colors.grey.shade200:Colors.blue[200]),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(widget.listMessages![index].message, style: TextStyle(fontSize: 15),),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: const Color.fromARGB(255, 43, 43, 43),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 213, 94, 85),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 20, ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        style: TextStyle(
                          color: Color.fromARGB(255, 184, 184, 184)
                        ),
                        decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Color.fromARGB(255, 184, 184, 184)),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: () async {
                        Message newMessage = Message(senderName: widget.myCustomer!.customerName, 
                            receiverName: widget.selectedTicket.recipientName, 
                            message: messageController.text, 
                            profilePicSender:widget.myCustomer!.profilePic);
                            
                        await ticketService.addMessageToTicket(newMessage, widget.selectedTicket);
                        widget.listMessages!.add(newMessage);
                        setState(() {});
                      },
                      child: Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: Color.fromARGB(255, 213, 94, 85),
                      elevation: 0,
                    ),
                  ],
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }
}
  
