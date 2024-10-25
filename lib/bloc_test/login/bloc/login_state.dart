class LoginState {
  final bool status;
  final String token;
  final String refreshToken;

  LoginState({this.status = false, this.token = '', this.refreshToken = ''});

  LoginState copyWith({
    bool? status,
    String? token,
    String? refreshToken,
  }) {
    return LoginState(
      status: status ?? this.status,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
