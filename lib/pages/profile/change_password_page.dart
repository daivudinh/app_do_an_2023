import 'package:application/blocs/blocs.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  static const String id = 'change_password';

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileBloc _bloc = BlocProvider.of<ProfileBloc>(context);

    final auth = FirebaseAuth.instance;

    void onConfirmChange() {
      showDialog(context: context, builder: (context) => const LoadingDialog());
      BlocProvider.of<ProfileBloc>(context).add(CheckErrorEvent(
        user: auth.currentUser,
        currentPassword: _bloc.currentController.text,
        newPassword: _bloc.newController.text,
        confirmPassword: _bloc.confirmController.text,
      ));
    }

    onChangePasswordSuccess(BuildContext context) {
      // back to profile page
      Navigator.of(context).pop();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Your password has been change!',
              style: kTextSize18w400White),
          backgroundColor: AppColor.background,
        ));
        // Add Your Code here.
        Navigator.of(context).pop();
      });
    }

    var changePasswordDialog = CustomDialog(
        title: 'Confirm Change Password',
        content: 'Are you want to change your password?',
        onSubmit: () => BlocProvider.of<ProfileBloc>(context).add(
            ChangePasswordEvent(
                user: auth.currentUser,
                newPassword: _bloc.newController.text)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password', style: kTextSize28w500White),
        centerTitle: true,
        backgroundColor: AppColor.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case ChangePasswordFailure:
                        Navigator.maybePop(context);
                        return ErrorMessageBox(
                            message:
                                (state as ChangePasswordFailure).errorMessage);
                      case ErrorIsClear:
                        Navigator.maybePop(context);
                        Future.delayed(Duration.zero).then((_) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => changePasswordDialog);
                        });

                        return const SizedBox();
                      case ChangePasswordSuccess:
                        onChangePasswordSuccess(context);

                        break;
                      default:
                        return const SizedBox();
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 20.0),
                const Text('Current Password', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  controller: _bloc.currentController,
                  hintText: 'Enter your current Password',
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  suffixIcon: true,
                ),
                const SizedBox(height: 20.0),
                const Text('New Password', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                    controller: _bloc.newController,
                    hintText: 'Enter your new Password',
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    suffixIcon: true),
                const SizedBox(height: 20.0),
                const Text('Confirm Password', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                    controller: _bloc.confirmController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    suffixIcon: true),
                const SizedBox(height: 20.0),
                ReusableButton(
                  onTap: () => onConfirmChange(),
                  buttonTitle: 'Confirm',
                  buttonColor: AppColor.red,
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
