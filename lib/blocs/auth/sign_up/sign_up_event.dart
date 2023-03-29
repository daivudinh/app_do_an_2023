abstract class SignUpEvent{}

class SendSignUpRequest extends SignUpEvent{
  final String email;
  final String password;
  final String confirm;
  SendSignUpRequest({required this.email,required this.password,required this.confirm});
}