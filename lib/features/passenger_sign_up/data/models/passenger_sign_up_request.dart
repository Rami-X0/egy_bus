class PassengerSignUpRequest {
  final String fullName;
  final String username;
  final String password;
  final String email;
  final String phoneNumber;

  PassengerSignUpRequest(
      {required this.fullName,
      required this.username,
      required this.password,
      required this.email,
      required this.phoneNumber});

  factory PassengerSignUpRequest.fromJson(Map<String, dynamic> json) {
    return PassengerSignUpRequest(
      fullName: json['fullName'],
      username: json['username'],
      password: json['passwordHash'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['username'] = username;
    data['passwordHash'] = password;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
