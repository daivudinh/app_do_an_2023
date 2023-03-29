import 'package:application/blocs/blocs.dart';
import 'package:application/models/models.dart';
import 'package:application/pages/pages.dart';
import 'package:application/services/shared_preferences.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _emailController = TextEditingController();
    // final _passwordController = TextEditingController();

    LoginBloc _bloc = BlocProvider.of<LoginBloc>(context);

    void onLogin() {
      String email = _bloc.emailController.text;
      String password = _bloc.passwordController.text;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(),
      );

      BlocProvider.of<LoginBloc>(context)
          .add(SendLoginRequest(email: email, password: password));
    }

    void gotoSignUp() {
      Navigator.of(context).pushNamed(SignUpPage.id);
    }

    void gotoForgotPassword() {
      Navigator.of(context).pushNamed(ForgotPasswordPage.id);
    }

    void gotoMainPage(Authentication auth) async {
      await HelperSharedPreferences.saveUid(auth.uid);
      await HelperSharedPreferences.saveToken(auth.token);
      await HelperSharedPreferences.saveLoginType(0);
      await HelperSharedPreferences.saveExpirationTime(auth.expiredToken);
      await HelperSharedPreferences.saveLogin(true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, MainPage.id);
      });
    }

    void gotoVerifyPage() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, VerifyEmail.id, (Route<dynamic> route) => false);
      });
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: SafeArea(
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
                      child: Text('Login',
                          style: kTextSize30w400White.copyWith(
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 20.0),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case LoginFailure:
                          Navigator.maybePop(context);
                          return ErrorMessageBox(
                              message: (state as LoginFailure).errorMessage);
                        case EmailIsNotVerify:
                          Future.delayed(Duration.zero).then((_) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => CustomDialog(
                                    title: 'Verify Email',
                                    hasTwoButton: false,
                                    content:
                                        'Your account is not verified yet. Verify now!',
                                    onSubmit: () => gotoVerifyPage()));
                          });
                          return const SizedBox();

                        case LoginSuccess:
                          Navigator.maybePop(context);
                          Authentication auth =
                              (state as LoginSuccess).authentication;
                          gotoMainPage(auth);
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
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    suffixIcon: true,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () => gotoForgotPassword(),
                        child: const Text('Forgot password?',
                            style: kTextSize20w400Blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ReusableButton(
                    onTap: () => onLogin(),
                    buttonTitle: 'Login',
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
                        const Text('Don\'t have an account?',
                            style: kTextSize18w400White),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                            onTap: () => gotoSignUp(),
                            child: const Text('Sign Up',
                                style: kTextSize18w400Red)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
