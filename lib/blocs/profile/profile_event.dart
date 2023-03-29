import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileEvent {}

class SaveProfileEvent extends ProfileEvent {
  final User user;
  final String name;

  SaveProfileEvent({required this.user, required this.name});
}

class CheckErrorEvent extends ProfileEvent{
  final User? user;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  CheckErrorEvent({
    required this.user,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class ChangePasswordEvent extends ProfileEvent {
  final String newPassword;
  final User? user;

  ChangePasswordEvent({required this.user,required this.newPassword});
}
