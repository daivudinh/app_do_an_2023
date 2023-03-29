import 'package:application/apis/apis.dart';
import 'package:application/blocs/blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../validation/validation.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final TextEditingController currentController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  ProfileBloc() : super(ProfileInitial()) {
    on<SaveProfileEvent>(_saveProfileEvent);
    on<CheckErrorEvent>(_onCheckErrorEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
  }

  Future<void> _saveProfileEvent(
      SaveProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      UserAPI userAPI = UserAPI();
      await userAPI.updateProfile(event.user, event.name);
      emit(SaveProfileSuccess());
    } catch (e) {
      emit(SaveProfileFailure());
      debugPrint(e.toString());
    }
  }

  Future<void> _onCheckErrorEvent(
      CheckErrorEvent event, Emitter<ProfileState> emit) async {
    try {
      bool check =
          await checkCurrentPassword(event.user!, event.currentPassword);
      if (!check) {
        emit(
            ChangePasswordFailure(errorMessage: 'Your password is incorrect!'));
      } else {
        String validateResult = validatePassword(event.newPassword);
        if (validateResult.isNotEmpty) {
          emit(ChangePasswordFailure(errorMessage: validateResult));
        } else {
          if (event.newPassword != event.confirmPassword) {
            emit(ChangePasswordFailure(errorMessage: 'Password not match!'));
          } else {
            emit(ErrorIsClear());
          }
        }
      }
    } catch (_) {
      emit(ChangePasswordFailure(errorMessage: 'Change password Fail!'));
    }
  }

  Future<void> _onChangePasswordEvent(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    try {
      UserAPI userAPI = UserAPI();
      await userAPI.updatePassword(event.user!, event.newPassword);
      emit(ChangePasswordSuccess());
    } catch (_) {
      emit(ChangePasswordFailure(errorMessage: 'Change password Fail!'));
    }
  }

  Future<bool> checkCurrentPassword(User user, String currentPassword) async {
    try {
      final auth = FirebaseAuth.instance;
      String? email = auth.currentUser?.email;
      if (email != null) {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: currentPassword);
        switch (userCredential.user == null) {
          case true:
            return false;
          case false:
            if (userCredential.user?.uid == user.uid) {
              return true;
            }
            break;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  String validatePassword(String password) {
    String result = '';
    if (password.isEmpty) {
      result = 'New Password is required!';
    } else if (!Validation().validatorPassword(password)) {
      result =
          'Incorrect password format\n(Must have: Upper, Lower, Number, Special, at least 6 characters.)';
    } else {
      result = '';
    }

    return result;
  }

  @override
  Future<void> close() {
    // TODO: implement close
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();

    return super.close();
  }
}
