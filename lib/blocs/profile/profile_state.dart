abstract class ProfileState{}

class ProfileInitial extends ProfileState{}

class SaveProfileSuccess extends ProfileState{}

class SaveProfileFailure extends ProfileState{}

class ErrorIsClear extends ProfileState{}

class ChangePasswordSuccess extends ProfileState{}

class ChangePasswordFailure extends ProfileState{
  final String errorMessage;
  ChangePasswordFailure({required this.errorMessage});
}