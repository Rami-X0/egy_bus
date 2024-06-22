class PassengerBookTripRequest {
  final int passengerId;
  final int tripId;
  final int seatsBooked;
  final int amountPaid;

  PassengerBookTripRequest({
    required this.passengerId,
    required this.tripId,
    required this.seatsBooked,
    required this.amountPaid,
  });

  factory PassengerBookTripRequest.fromJson(Map<String, dynamic> json) {
    return PassengerBookTripRequest(
      passengerId: json['passengerId'],
      tripId: json['tripId'],
      seatsBooked: json['seatsBooked'],
      amountPaid: json['amountPaid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['passengerId'] = passengerId;
    data['tripId'] = tripId;
    data['seatsBooked'] = seatsBooked;
    data['amountPaid'] = amountPaid;
    return data;
  }
}
