import 'package:application/pages/pages.dart';
import 'package:application/services/services.dart';
import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    HelperSharedPreferences.getLogin().then((value) {
      isLogin = value ?? false;
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    checkLogin();
    super.didChangeDependencies();
  }

  void checkLogin() {
    HelperSharedPreferences.getExpirationTime().then((value) {
      int timeNow = DateTime.now().millisecondsSinceEpoch;
      Future.delayed(const Duration(seconds: 3)).then((_) {
        if (value != null && value >= timeNow && isLogin && value != -1) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (Route<dynamic> route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginPage.id, (Route<dynamic> route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Welcome to The Movie App',
                textAlign: TextAlign.center,
                style: kTextSize30w400White.copyWith(
                  fontWeight: FontWeight.bold,
                )),
          )),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 50.0,
            width: 50.0,
            child: Image.asset(
              'assets/images/image_placeholder.gif',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
