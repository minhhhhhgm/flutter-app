class LoginResponse {
  final bool status;
  final String token;
  final String refreshToken;


  LoginResponse({
    required this.status,
    required this.token,
    required this.refreshToken
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'token': token,
      'refreshToken':refreshToken
    };
  }
  
  
}