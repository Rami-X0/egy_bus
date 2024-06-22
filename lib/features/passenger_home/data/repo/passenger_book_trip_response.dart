class PassengerBookTripResponse {
  final String message;
  final int bookingId;

  PassengerBookTripResponse({required this.message, required this.bookingId});
factory PassengerBookTripResponse.fromJson(Map<String, dynamic> json) {
  return PassengerBookTripResponse(
    message: json['message'],
    bookingId: json['bookingId'],
  );
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['bookingId'] = bookingId;
    return data;
  }
}
