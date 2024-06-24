class PassengerBookResponse {
  final int id;
  final int passengerId;
  final String passengerName;
  final int tripId;
  final String fromStation;
  final String toStationStation;
  final int seatsBooked;
  final double amountPaid;
  final String bookingDate;

  PassengerBookResponse(
      {required this.id,
      required this.passengerId,
      required this.passengerName,
      required this.tripId,
      required this.fromStation,
      required this.toStationStation,
      required this.seatsBooked,
      required this.amountPaid,
      required this.bookingDate});

  factory PassengerBookResponse.fromJson(Map<String, dynamic> json) {
    return PassengerBookResponse(
      id: json['id'],
      passengerId: json['passengerId'],
      passengerName: json['passengerName'],
      tripId: json['tripId'],
      fromStation: json['fromStation'],
      toStationStation: json['toStationStation'],
      seatsBooked: json['seatsBooked'],
      amountPaid: json['amountPaid'],
      bookingDate: json['bookingDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['passengerId'] = passengerId;
    data['passengerName'] = passengerName;
    data['tripId'] = tripId;
    data['fromStation'] = fromStation;
    data['toStationStation'] = toStationStation;
    data['seatsBooked'] = seatsBooked;
    data['amountPaid'] = amountPaid;
    data['bookingDate'] = bookingDate;
    return data;
  }
}
