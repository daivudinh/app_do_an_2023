import 'package:application/blocs/blocs.dart';
import 'package:application/models/models.dart';
import 'package:application/pages/pages.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  static const String id = 'sign_up';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpBloc _bloc = BlocProvider.of<SignUpBloc>(context);

    // bool obscureText = true;
    // bool obscureTextConfirm = true;

    void onSingUp() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(),
      );

      _bloc.add(
        SendSignUpRequest(
            email: _bloc.emailController.text,
            password: _bloc.passwordController.text,
            confirm: _bloc.confirmController.text),
      );
    }

    void gotoVerifyPage(Authentication auth) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, VerifyEmail.id, (Route<dynamic> route) => false,
            arguments: {auth: auth});
      });
    }

    void backToLogin() {
      Navigator.of(context).pushReplacementNamed(LoginPage.id);
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
                    child: Text('Register',
                        style: kTextSize30w400White.copyWith(
                            fontWeight: FontWeight.bold))),
                const SizedBox(height: 20.0),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case SignUpFailure:
                        Navigator.maybePop(context);
                        return ErrorMessageBox(
                            message: (state as SignUpFailure).errorMessage);
                      case SignUpSuccess:
                        Navigator.maybePop(context);
                        Authentication auth =
                            (state as SignUpSuccess).authentication;
                        gotoVerifyPage(auth);
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
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                const Text('Password', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  hintText: 'Enter your Password',
                  controller: _bloc.passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  suffixIcon: true,
                ),
                const SizedBox(height: 20.0),
                const Text('Confirm Password', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  hintText: 'Confirm Password',
                  controller: _bloc.confirmController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  suffixIcon: true,
                ),
                const SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
                ReusableButton(
                  onTap: () => onSingUp(),
                  buttonTitle: 'Sign Up',
                  buttonColor: AppColor.red,
                ),
                const SizedBox(height: 20.0),
                AnotherLoginMethod(
                  onFacebookLogin: () {},
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Wrap(
                    children: [
                      const Text('Already have an account?',
                          style: kTextSize18w400White),
                      const SizedBox(width: 10.0),
                      GestureDetector(
                          onTap: () => backToLogin(),
                          child:
                              const Text('Sign In', style: kTextSize18w400Red)),
                    ],
                  ),
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
