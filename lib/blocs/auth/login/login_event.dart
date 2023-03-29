abstract class LoginEvent{}

class SendLoginRequest extends LoginEvent{
  final String email;
  final String password;
  SendLoginRequest({required this.email,required this.password});
}