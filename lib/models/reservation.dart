class Reservation {
  late final String idCustomer;
  late final String idRestaurant;
  late final String restaurantName;
  late final String dateReservation;
  late final String timeReservation;
  late final String creationDate;

  Reservation(
      {required this.idCustomer,
      required this.idRestaurant,
      required this.restaurantName,
      required this.dateReservation,
      required this.timeReservation});

  factory Reservation.fromJSON(dynamic json) {
    return Reservation(
        idCustomer: json['_idCustomer'],
        idRestaurant: json['_idRestaurant'],
        restaurantName: json['restaurantName'],
        dateReservation: json['dateReservation'],
        timeReservation: json['timeReservation']);
  }
  @override
  String toString() {
    return 'Reservation {idCustomer: $idCustomer, idRestaurant: $idRestaurant, restaurantName: $restaurantName, dateReservation: $dateReservation, timeReservation: $timeReservation }';
  }
}
