import 'package:application/blocs/blocs.dart';
import 'package:application/pages/pages.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String id = 'forgot_password';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    ForgotPasswordBloc _bloc = BlocProvider.of<ForgotPasswordBloc>(context);

    void backToLogin() {
      Navigator.of(context).pushReplacementNamed(LoginPage.id);
    }

    void onSendEmail() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(),
      );

      BlocProvider.of<ForgotPasswordBloc>(context)
          .add(SendEmailRequest(email: _bloc.emailController.text));
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Center(
                    child: Text('THE MOVIE',
                        style: kTextSize30w400White.copyWith(
                            fontWeight: FontWeight.bold))),
                Center(
                  child: SizedBox(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset(
                      'assets/images/themovie_app_icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                    child: Text('Forgot password',
                        style: kTextSize30w400White.copyWith(
                            fontWeight: FontWeight.bold))),
                const SizedBox(height: 20.0),
                BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case SendEmailFailure:
                        Navigator.maybePop(context);
                        return ErrorMessageBox(
                            message: (state as SendEmailFailure).errorMessage);
                      case SendEmailSuccess:
                        Navigator.maybePop(context);
                        Future.delayed(
                          Duration.zero,
                          () => showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => CustomDialog(
                              title: 'Notifications!',
                              content:
                                  'Password reset link has been sent to your email!',
                              onSubmit: () {
                                Navigator.pop(context);
                                backToLogin();
                              },
                              hasTwoButton: false,
                            ),
                          ),
                        );
                        break;
                      default:
                        return const SizedBox();
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 10.0),
                const Text('Email', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  hintText: 'Enter your Email',
                  controller: _bloc.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20.0),
                ReusableButton(
                  onTap: () => onSendEmail(),
                  buttonTitle: 'Send',
                  buttonColor: AppColor.red,
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: GestureDetector(
                      onTap: () => backToLogin(),
                      child: const Text('Back to Login',
                          style: kTextSize18w400Blue)),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
