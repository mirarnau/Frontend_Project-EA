import 'package:flutter/material.dart';

class ReservationWidget extends StatelessWidget {
  final String creatorName;
  final String subject;
  final String status;

  ReservationWidget({
    required this.creatorName,
    required this.subject,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 111.0,
        width: 350.0,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 161, 90, 85),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: <Widget>[
            /*
              Container(
                width: 60,
                height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(imageURL),
                    )
                  ),
                ),
                */
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            creatorName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          const Text("Reservation",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ))
                        ],
                      ),
                      Text(
                        subject,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Text(
                        status,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 24.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
