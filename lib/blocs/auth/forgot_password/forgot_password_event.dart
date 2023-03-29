abstract class ForgotPasswordEvent{}

class SendEmailRequest extends ForgotPasswordEvent{
  final String email;
  SendEmailRequest({required this.email});
}