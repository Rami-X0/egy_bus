class DriverSignUpRequest {
  final String fullName;
  final String username;
  final String password;
  final String email;
  final String phoneNumber;

  DriverSignUpRequest(
      {required this.fullName,
      required this.username,
      required this.password,
      required this.email,
      required this.phoneNumber});

  factory DriverSignUpRequest.fromJson(Map<String, dynamic> json) {
    return DriverSignUpRequest(
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
