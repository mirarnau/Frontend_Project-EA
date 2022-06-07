class Reservation {
  final String Subject;
  final String StartTime;
  final String EndTime;

  final String AllDay;

  Reservation(
      {required this.Subject,
      required this.StartTime,
      required this.EndTime,
      required this.AllDay});

  factory Reservation.fromJSON(dynamic json) {
    return Reservation(
        Subject: json['Subject'],
        StartTime: json['StartTime'],
        EndTime: json['EndTIme'],
        AllDay: json['AllDay']);
  }

  //Just to customize the print to parse the JSON correctly in an inteligible format.
  @override
  String toString() {
    return 'Dish {title: $Subject, price: $StartTime, rating: $EndTime, imageUrl: $AllDay }';
  }
}
