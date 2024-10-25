
abstract class LoginEvent {}

class OnChangeEmail extends LoginEvent{
  final String email;
  OnChangeEmail({required this.email});
}

class OnChangePassword extends LoginEvent{
  final String password;
  OnChangePassword({required this.password});
}

class OnSubmitting extends LoginEvent{

}

class OnLogin extends LoginEvent{

}