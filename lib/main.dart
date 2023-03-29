import 'package:application/blocs/blocs.dart';
import 'package:application/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/cast_and_crew/cast_and_crew_page.dart';
import 'repositories/repositories.dart';
import 'services/auth.dart';
import 'values/values.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: apiKey,
          appId: '1:146548645926:android:4102d92335f5efb779c6e7',
          messagingSenderId: '146548645926',
          projectId: 'app-do-an-6f3b4'));
  runApp(const TheMovieApp());
}

class TheMovieApp extends StatelessWidget {
  const TheMovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          fontFamily: "Lato",
          scaffoldBackgroundColor: AppColor.background),
      routes: {
        /// auth
        LoginPage.id: (context) => BlocProvider(
              create: (context) => LoginBloc(authService: AuthService()),
              child: const LoginPage(),
            ),
        SignUpPage.id: (context) => BlocProvider(
              create: (context) => SignUpBloc(authService: AuthService()),
              child: const SignUpPage(),
            ),
        ForgotPasswordPage.id: (context) => BlocProvider(
              create: (context) => ForgotPasswordBloc(
                authService: AuthService(),
              ),
              child: const ForgotPasswordPage(),
            ),
        VerifyEmail.id: (context) => const VerifyEmail(),

        /// detail
        MovieDetailPage.id: (context) => BlocProvider(
              create: (context) => MovieDetailBloc(DetailRepository()),
              child: const MovieDetailPage(),
            ),
        TVSeriesDetailPage.id: (context) => BlocProvider(
              create: (context) => TVSeriesDetailBloc(DetailRepository()),
              child: const TVSeriesDetailPage(),
            ),
        CastAndCrewPage.id: (context) => BlocProvider(
              create: (context) => CastAndCrewBloc(),
              child: const CastAndCrewPage(),
            ),
        CastDetailPage.id: (context) => const CastDetailPage(),
        CrewDetailPage.id: (context) => const CrewDetailPage(),

        ChangePasswordPage.id: (context) => BlocProvider(
              create: (context) => ProfileBloc(),
              child: const ChangePasswordPage(),
            ),
        MainPage.id: (context) => const MainPage(),
      },
      home:
          // const VerifyEmail()
          BlocProvider(
        create: (context) => LoginBloc(authService: AuthService()),
        child: const SplashScreen(),
      ),
    );
  }
}
