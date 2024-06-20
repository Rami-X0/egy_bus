class BusLineResponse {
  final int id;
  final String name;
  final String location;
  final double stationLat;
  final double stationLong;

  BusLineResponse({
    required this.id,
    required this.name,
    required this.location,
    required this.stationLat,
    required this.stationLong,
  });

  factory BusLineResponse.fromJson(Map<String, dynamic> json) {
    return BusLineResponse(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      stationLat: json['stationLat'],
      stationLong: json['stationLong'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['stationLat'] = stationLat;
    data['stationLong'] = stationLong;
    return data;
  }
}
