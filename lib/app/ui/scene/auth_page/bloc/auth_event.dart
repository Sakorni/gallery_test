part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  SignIn({@required this.email, @required this.password});
}

class SignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String bDayDate;

  SignUp(
      {@required this.name,
      @required this.email,
      @required this.password,
      @required this.bDayDate,
      @required this.confirmPassword});
}
