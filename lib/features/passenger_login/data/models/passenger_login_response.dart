class PassengerLoginResponse {
  final String accessToken;
  final String tokenType;
  final int userId;
  final String userName;
  final int expiresIn;
  final int creationTime;
  final int expirationTime;
  final int accountId;
  final String email;

  PassengerLoginResponse(
      {required this.accessToken,
      required this.tokenType,
      required this.userId,
      required this.userName,
      required this.expiresIn,
      required this.creationTime,
      required this.expirationTime,
      required this.accountId,
      required this.email});

 factory PassengerLoginResponse.fromJson(Map<String, dynamic> json) {
    return PassengerLoginResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      userId: json['user_Id'],
      userName: json['user_name'],
      expiresIn: json['expires_in'],
      creationTime: json['creation_Time'],
      expirationTime: json['expiration_Time'],
      accountId: json['accountid'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['user_Id'] = userId;
    data['user_name'] = userName;
    data['expires_in'] = expiresIn;
    data['creation_Time'] = creationTime;
    data['expiration_Time'] = expirationTime;
    data['accountid'] = accountId;
    data['email'] = email;
    return data;
  }
}
