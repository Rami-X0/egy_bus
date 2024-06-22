class PassengerPaymentRequest {
  final int bookingId;
  final int amount;
  final String paymentDate;
  final int paymentTypeId;

  PassengerPaymentRequest({
    required this.bookingId,
    required this.amount,
    required this.paymentDate,
    required this.paymentTypeId,
  });


  factory PassengerPaymentRequest.fromJson(Map<String, dynamic> json) {
    return PassengerPaymentRequest(
      bookingId: json['bookingId'],
      amount: json['amount'],
      paymentDate: json['paymentDate'],
      paymentTypeId: json['paymentTypeId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingId'] = bookingId;
    data['amount'] = amount;
    data['paymentDate'] = paymentDate;
    data['paymentTypeId'] = paymentTypeId;
    return data;
  }
}
