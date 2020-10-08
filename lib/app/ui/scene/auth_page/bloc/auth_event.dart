part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  SignIn(this.email, this.password);
}

class SignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String bDayDate;

  SignUp(this.name, this.email, this.password, this.bDayDate);
}
