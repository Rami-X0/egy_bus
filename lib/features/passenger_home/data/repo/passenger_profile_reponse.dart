class PassengerProfileResponse {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String phoneNumber;
  final int passengerLat;
  final int passengerLong;

  PassengerProfileResponse(
      {
        required this.id,
        required this.username,
        required this.fullName,
        required this.email,
        required this.phoneNumber,
        required this.passengerLat,
        required this.passengerLong});

factory PassengerProfileResponse.fromJson(Map<String, dynamic> json) {
  return PassengerProfileResponse(
    id: json['id'],
    username: json['username'],
    fullName: json['fullName'],
    email: json['email'],
    phoneNumber: json['phoneNumber'],
    passengerLat: json['passengerLat'],
    passengerLong: json['passengerLong'],
  );
}
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['passengerLat'] = passengerLat;
    data['passengerLong'] = passengerLong;
    return data;
  }
}
