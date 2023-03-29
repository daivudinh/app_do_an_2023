import 'package:firebase_auth/firebase_auth.dart';

abstract class AvatarEvent{}

class ChangeAvatarEvent extends AvatarEvent {
  final User user;
  final String imagePath;

  ChangeAvatarEvent({required this.user, required this.imagePath});
}