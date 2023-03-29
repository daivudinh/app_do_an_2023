import 'package:application/models/models.dart';
import 'package:application/services/services.dart';
import 'package:application/validation/validation.dart';
import 'package:application/values/values.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../blocs.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<SendLoginRequest>(_onSendLoginRequest);
  }

  Future _onSendLoginRequest(
      SendLoginRequest event, Emitter<LoginState> emit) async {
    try {
      String check = checkValidate(event.email, event.password);

      if (check.isNotEmpty) {
        emit(LoginFailure(errorMessage: check));
        emit(LoginFailure(errorMessage: check));
      } else {
        FirebaseAuth _auth = FirebaseAuth.instance;
        var authenticationObj = await authService.signInWithEmailAndPassword(
            event.email, event.password);
        bool emailVerified = _auth.currentUser?.emailVerified ?? false;

        if (authenticationObj.runtimeType == Authentication) {
          if (emailVerified) {
            emit(LoginSuccess(authentication: authenticationObj));
          } else {
            emit(EmailIsNotVerify());
            // emit(LoginFailure(errorMessage: 'Your account is not verified yet please check your email!'));
          }
        } else if (authenticationObj.runtimeType == FirebaseAuthException) {
          emit(LoginFailure(
              errorMessage:
                  checkFirebaseAuthExceptionError(authenticationObj)));
        }
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  String checkValidate(String email, String password) {
    String result = '';

    if (email.isEmpty && password.isEmpty) {
      result = 'Email is required\nPassword is required';
    }

    if (email.isEmpty && password.isNotEmpty) {
      result = 'Email is required';
    }

    if (email.isNotEmpty && password.isEmpty) {
      result = 'Password is required';
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      if (!Validation().validatorEmail(email)) {
        result = 'Incorrect email format';
      } else if (password.length < 6) {
        result = 'Password at least 6 characters';
      }
    }

    return result;
  }

  @override
  Future<void> close() {
    // TODO: implement close
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
