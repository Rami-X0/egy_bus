class AddBookModel{
 final double passengerLat;
 final double passengerLon;
 final double stationLat;
 final double stationLon;


  AddBookModel({
    required this.passengerLat,
    required this.passengerLon,
    required this.stationLat,
    required this.stationLon,
  });
 factory AddBookModel.fromJson(Map<String, dynamic> json) {
    return AddBookModel(
      passengerLat: json['passengerLat'],
      passengerLon: json['passengerLon'],
      stationLat: json['stationLat'],
      stationLon: json['stationLon'],
    );
  }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['passengerLat'] = passengerLat;
    data['passengerLon'] = passengerLon;
    data['stationLat'] = stationLat;
    data['stationLon'] = stationLon;
    return data;
  }
}