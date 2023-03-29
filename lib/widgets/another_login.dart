import 'package:application/pages/pages.dart';
import 'package:application/services/services.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnotherLoginMethod extends StatelessWidget {
  const AnotherLoginMethod({Key? key, required this.onFacebookLogin})
      : super(key: key);

  final Function()? onFacebookLogin;

  @override
  Widget build(BuildContext context) {
    void gotoMainPage() {
      Navigator.pushReplacementNamed(context, MainPage.id);
      // WidgetsBinding.instance!.addPostFrameCallback((_) {
      //   Navigator.pushReplacementNamed(context, MainPage.id);
      // });
    }

    void onGoogleLogin() async {
      final auth = FirebaseAuth.instance;
      try {
        await AuthService().signInWithGoogle(context: context);
        if (auth.currentUser != null) {
          var idTokenResult = await auth.currentUser!.getIdTokenResult();
          String uid = auth.currentUser!.uid;
          String token = idTokenResult.token ?? '';
          int expirationTime =
              idTokenResult.expirationTime!.millisecondsSinceEpoch;
          await HelperSharedPreferences.saveUid(uid);
          await HelperSharedPreferences.saveToken(token);
          await HelperSharedPreferences.saveLoginType(1);
          await HelperSharedPreferences.saveExpirationTime(expirationTime);
          await HelperSharedPreferences.saveLogin(true);
          Navigator.pop(context); // close loading dialog
          gotoMainPage();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    Future<void> onFacebookLogin() async {
      final auth = FirebaseAuth.instance;
      try {
        await AuthService().signInWithFacebook(context: context);

        if (auth.currentUser != null) {
          var idTokenResult = await auth.currentUser!.getIdTokenResult();
          String uid = auth.currentUser!.uid;
          String token = idTokenResult.token ?? '';
          int expirationTime =
              idTokenResult.expirationTime!.millisecondsSinceEpoch;
          await HelperSharedPreferences.saveUid(uid);
          await HelperSharedPreferences.saveToken(token);
          await HelperSharedPreferences.saveLoginType(2);
          await HelperSharedPreferences.saveExpirationTime(expirationTime);
          await HelperSharedPreferences.saveLogin(true);
          // Navigator.pop(context); // close loading dialog
          gotoMainPage();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Expanded(
              child: HorizontalDivider(),
            ),
            Text('or', style: kTextSize20w400White),
            Expanded(
              child: HorizontalDivider(),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => onGoogleLogin(),
          child: Container(
            height: 50,
            width: double.infinity,
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
                    'assets/images/google.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15.0),
                const Text('Login with Google', style: kTextSize18w400White),
                const Spacer(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        GestureDetector(
          onTap: () => onFacebookLogin(),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: AppColor.white25),
                color: AppColor.blur),
            child: Row(
              children: [
                const Spacer(),
                SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: Image.asset(
                    'assets/images/facebook.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15.0),
                const Text('Login with Facebook', style: kTextSize18w400White),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
