import 'package:flutter/material.dart';

class ReservationWidget extends StatelessWidget {
  final String dateDay;
  final String dateTime;
  final String nameCust;
  final String nameRest;
  final String phone;

  ReservationWidget({
    required this.dateDay,
    required this.dateTime,
    required this.nameCust,
    required this.nameRest,
    required this.phone
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 145.0,
        width: 350.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: <Widget>[
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
                            nameCust,
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
                        "Phone: " + phone,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Text(
                        "Day: " + dateDay,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Text(
                        "Hour: " + dateTime,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Text(
                        "Restaurant: " + nameRest,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.remove_circle_outline,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
