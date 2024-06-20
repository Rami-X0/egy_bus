class PassengerLoginRequest {
  final String username;
  final String password;

  PassengerLoginRequest({
    required this.username,
    required this.password,
  });

  factory PassengerLoginRequest.fromJson(Map<String, dynamic> json) {
    return PassengerLoginRequest(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
