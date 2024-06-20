class DriverLoginRequest {
  final String username;
  final String password;

  DriverLoginRequest({
    required this.username,
    required this.password,
  });

  factory DriverLoginRequest.fromJson(Map<String, dynamic> json) {
    return DriverLoginRequest(
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
