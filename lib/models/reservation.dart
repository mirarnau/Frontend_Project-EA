class Reservation {
  late final String idCustomer;
  late final String restaurantName;
  late final String dateReservation;
  late final String timeReservation;
  late final String creationDate;

  Reservation(
      {required this.idCustomer,
      required this.restaurantName,
      required this.dateReservation,
      required this.timeReservation});

  factory Reservation.fromJSON(dynamic json) {
    return Reservation(
        idCustomer: json['_idCustomer'],
        restaurantName: json['restaurantName'],
        dateReservation: json['dateReservation'],
        timeReservation: json['timeReservation']);
  }
  @override
  String toString() {
    return 'Reservation {idCustomer: $idCustomer, restaurantName: $restaurantName, dateReservation: $dateReservation, timeReservation: $timeReservation }';
  }

  static Map<String, dynamic> toJson(Reservation reservation) {
    return {
      '_idCustomer': reservation.idCustomer,
      'restaurantName': reservation.restaurantName,
      'dateReservation': reservation.dateReservation,
      'timeReservation': reservation.timeReservation,
    };
  }
}
