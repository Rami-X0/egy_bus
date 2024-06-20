class AddTripeRequest {
  final int fromStationId;
  final int toStationId;
  final String departureTime;
  final int availableSeats;
  final int price;
  final int driverId;
  final String busPlate;

  AddTripeRequest({
    required this.fromStationId,
    required this.toStationId,
    required this.departureTime,
    required this.availableSeats,
    required this.price,
    required this.driverId,
    required this.busPlate,
  });

  factory AddTripeRequest.fromJson(Map<String, dynamic> json) {
    return AddTripeRequest(
      fromStationId: json['fromStationId'],
      toStationId: json['toStationId'],
      departureTime: json['departureTime'],
      availableSeats: json['availableSeats'],
      price: json['price'],
      driverId: json['driverId'],
      busPlate: json['busPlate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromStationId'] = fromStationId;
    data['toStationId'] = toStationId;
    data['departureTime'] = departureTime;
    data['availableSeats'] = availableSeats;
    data['price'] = price;
    data['driverId'] = driverId;
    data['busPlate'] = busPlate;
    return data;
  }
}
