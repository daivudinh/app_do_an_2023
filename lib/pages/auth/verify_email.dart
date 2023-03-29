import 'dart:async';

import 'package:application/pages/pages.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../../services/services.dart';

class VerifyEmail extends StatefulWidget {
  static const String id = 'verify_email';

  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = _auth.currentUser!;

    user.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  void gotoMainPage() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var idTokenResult = await auth.currentUser!.getIdTokenResult();
    String uid = auth.currentUser!.uid;
    String token = idTokenResult.token ?? '';
    int expirationTime = idTokenResult.expirationTime!.millisecondsSinceEpoch;

    await HelperSharedPreferences.saveUid(uid);
    await HelperSharedPreferences.saveToken(token);
    await HelperSharedPreferences.saveLoginType(0);
    await HelperSharedPreferences.saveExpirationTime(expirationTime);
    await HelperSharedPreferences.saveLogin(true);

    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   Navigator.pushReplacementNamed(context, MainPage.id);
    // });

    Navigator.of(context).pushReplacementNamed(MainPage.id);
  }

  Future<void> checkEmailVerified() async {
    user = _auth.currentUser!;
    await user.reload();

    if (user.emailVerified) {
      timer.cancel();
      showDialog(context: context, builder: (context) => const LoadingDialog());
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Navigator.of(context).pop();
        gotoMainPage();
      });
    }
  }

  void onOpenEmail() async {
    try {
      var result = await OpenMailApp.openMailApp();

      // If no mail apps found, show error
      if (!result.didOpen && !result.canOpen) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              title: 'Open Mail App',
              content: 'No mail apps installed',
              onSubmit: () => Navigator.of(context).pop(),
              hasTwoButton: false,
            );
          },
        );

        // iOS: if multiple mail apps found, show dialog to select.
        // There is no native intent/default app system in iOS so
        // you have to do it yourself.
      } else if (!result.didOpen && result.canOpen) {
        showDialog(
          context: context,
          builder: (_) {
            return MailAppPickerDialog(
              mailApps: result.options,
            );
          },
        );
      }
      return null;
    } catch (e) {
      debugPrint('Could not launch Mail App');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
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
                const SizedBox(height: 30.0),
                const Center(
                  child: Text('Verify your Email', style: kTextSize25w400White),
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: Text('An email has been sent to:',
                      style: kTextSize18w400White.copyWith(
                          color: AppColor.iconColorStart)),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: Text(user.email ?? "",
                      style: kTextSize20w400White.copyWith(
                          fontStyle: FontStyle.italic)),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: Text('Please verify',
                      style: kTextSize18w400White.copyWith(
                          color: AppColor.iconColorStart)),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: onOpenEmail,
                  child: Container(
                    height: 50.0,
                    // width: 200.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: AppColor.white25),
                        color: AppColor.blur),
                    child: Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: Image.asset(
                            'assets/images/gmail.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        const Text('Open gmail', style: kTextSize18w400White),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
