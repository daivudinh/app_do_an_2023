import 'package:application/services/services.dart';
import 'package:application/validation/validation.dart';
import 'package:application/values/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../blocs.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthService authService;

  final emailController = TextEditingController();

  ForgotPasswordBloc({required this.authService})
      : super(ForgotPasswordInitial()) {
    on<SendEmailRequest>(_onSendEmailRequest);
  }

  Future _onSendEmailRequest(
      SendEmailRequest event, Emitter<ForgotPasswordState> emit) async {
    try {
      if (event.email.isEmpty) {
        emit(SendEmailFailure(errorMessage: 'Email is required!'));
      } else if (!Validation().validatorEmail(event.email)) {
        emit(SendEmailFailure(errorMessage: 'Incorrect email format!'));
      } else {
        var obj = await authService.sendPasswordResetEmail(event.email);
        if (obj.runtimeType == FirebaseAuthException) {
          emit(SendEmailFailure(
              errorMessage: checkFirebaseAuthExceptionError(obj)));
        } else {
          emit(SendEmailSuccess());
        }
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    emailController.dispose();

    return super.close();
  }
}
