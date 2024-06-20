class AllTripResponse {
  final int id;
  final double fromLongitude;
  final double fromLatitude;
  final int fromStationId;
  final String fromStationName;
  final int toStationId;
  final String toStationName;
  final String departureTime;
  final int availableSeats;
  final double price;
  final int driverId;
  final String driverName;
  final String busPlate;

  AllTripResponse({
    required this.id,
    required this.fromLongitude,
    required this.fromLatitude,
    required this.fromStationId,
    required this.fromStationName,
    required this.toStationId,
    required this.toStationName,
    required this.departureTime,
    required this.availableSeats,
    required this.price,
    required this.driverId,
    required this.driverName,
    required this.busPlate,
  });
 factory AllTripResponse.fromJson(Map<String, dynamic> json) {
   return AllTripResponse(
     id: json['id'],
     fromLongitude: json['fromLongitude'],
     fromLatitude: json['fromLatitude'],
     fromStationId: json['fromStationId'],
     fromStationName: json['fromStationName'],
     toStationId: json['toStationId'],
     toStationName: json['toStationName'],
     departureTime: json['departureTime'],
     availableSeats: json['availableSeats'],
     price: json['price'],
     driverId: json['driverId'],
     driverName: json['driverName'],
     busPlate: json['busPlate'],
   );
 }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fromLongitude'] = fromLongitude;
    data['fromLatitude'] = fromLatitude;
    data['fromStationId'] = fromStationId;
    data['fromStationName'] = fromStationName;
    data['toStationId'] = toStationId;
    data['toStationName'] = toStationName;
    data['departureTime'] = departureTime;
    data['availableSeats'] = availableSeats;
    data['price'] = price;
    data['driverId'] = driverId;
    data['driverName'] = driverName;
    data['busPlate'] = busPlate;
    return data;
  }
}
