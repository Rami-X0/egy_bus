class DriverAddBusLineRequest {
  final String lineCode;
  final int stationIdFrom;
  final int stationIdTo;

  DriverAddBusLineRequest({
    required this.lineCode,
    required this.stationIdFrom,
    required this.stationIdTo,
  });


  factory DriverAddBusLineRequest.fromJson(Map<String, dynamic> json) {
    return DriverAddBusLineRequest(
      lineCode: json['lineCode'],
      stationIdFrom: json['stationIdFrom'],
      stationIdTo: json['stationIdTo'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lineCode'] = lineCode;
    data['stationIdFrom'] = stationIdFrom;
    data['stationIdTo'] = stationIdTo;
    return data;
  }
}
