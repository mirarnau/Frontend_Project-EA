class Reservation {
  late final String idCustomer;
  late final String idRestaurant;
  late final String nameCustomer;
  late final String nameRestaurant;
  late final String dateReservation;
  late final String timeReservation;
  late final String creationDate;
  late final String phone;
  late final int numCustomers;

  Reservation(
      {
        required this.idCustomer,
        required this.idRestaurant,
        required this.nameCustomer,
        required this.nameRestaurant,
        required this.dateReservation,
        required this.timeReservation,
        required this.phone,
        required this.numCustomers
      });

  factory Reservation.fromJSON(dynamic json) {
    return Reservation(
      idCustomer: json['_idCustomer'],
      idRestaurant: json['_idRestaurant'],
      nameCustomer: json['nameCustomer'],
      nameRestaurant: json['nameRestaurant'],
      dateReservation: json['dateReservation'],
      timeReservation: json['timeReservation'], 
      numCustomers: json['numCustomers'],
      phone: json['phone']
    );
  }
  @override
  String toString() {
    return 
      'Reservation {idCustomer: $idCustomer, restaurantName: $idRestaurant, nameCustomer: $nameCustomer, nameRestaurant: $nameRestaurant, numCustomers: $numCustomers, phone: $phone, dateReservation: $dateReservation, timeReservation: $timeReservation }';
  }

  static Map<String, dynamic> toJson(Reservation reservation) {
    return {
      '_idCustomer': reservation.idCustomer,
      '_idRestaurant': reservation.idRestaurant,
      'nameCustomer': reservation.nameCustomer,
      'nameRestaurant': reservation.nameRestaurant,
      'numCustomers': reservation.numCustomers,
      'phone': reservation.phone,
      'dateReservation': reservation.dateReservation,
      'timeReservation': reservation.timeReservation,
    };
  }
}
