import 'package:application/models/models.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final Authentication authentication;
  LoginSuccess({required this.authentication});
}

class EmailIsNotVerify extends LoginState {}

class LoginFailure extends LoginState {
  final String errorMessage;
  LoginFailure({required this.errorMessage});
}
