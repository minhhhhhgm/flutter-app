import 'package:flutter_application_1/bloc_test/login/bloc/login_event.dart';
import 'package:flutter_application_1/bloc_test/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String email = '';
  String password = '';
  LoginBloc() : super(LoginState()) {
    on<OnChangeEmail>(onChangeEmail);
    on<OnChangePassword>(onChangePassword);
    on<OnLogin>(onLogin);
  }

  void onChangeEmail(OnChangeEmail event, Emitter<LoginState> emit) {
    email = event.email;
    print('email $email');
  }

  void onChangePassword(OnChangePassword event, Emitter<LoginState> emit) {
    password = event.password;
    print('password $password');
  }

  void onLogin(OnLogin event, Emitter<LoginState> emit) async {
    // add(OnSubmitting());
    try {
      final url = Uri.parse('http://10.22.20.8:4000/api/login');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = json.decode(response.body);
      print(data);
    } catch (e) {
      print(e);
    }
  }
}
