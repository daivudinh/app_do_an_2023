import 'package:application/values/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const String image =
    'https://image.tmdb.org/t/p/w500/jOuCWdh0BE6XPu2Vpjl08wDAeFz.jpg';
const String image2 =
    'https://image.tmdb.org/t/p/w500/qtX2Fg9MTmrbgN1UUvGoCsImTM8.jpg';

const String noPosterImage =
    'https://www.prokerala.com/movies/assets/img/no-poster-available.jpg';
const String noProfileImage =
    "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";

const String baseUrlImage = "https://image.tmdb.org/t/p/w500";
const String youtubeUrl = "https://www.youtube.com/embed/";

const String baseURL = "https://api.themoviedb.org/3";
const String apiKey = "69174be844f78c34aaf4cc655a1f74bb";

const String argsKeyType = "Type"; // 1: Movie, 2: TVSeries
const String argsKeyMovieId = 'movieId';
const String argsKeyMovieName = 'movieName';

const String argsKeyTvSeriesId = 'tvSeriesId';
const String argsKeyTvSeriesName = 'tvSeriesName';

const ImageProvider placeholderImage =
    AssetImage('assets/images/placeholder.gif');

const defaultParam = {
  "api_key": apiKey,
  "language": 'en-US',
};

Map<String, dynamic> paramWithPage({required int page}) {
  return {"api_key": apiKey, "language": 'en-US', "page": page};
}

String getGender(int gender) {
  String result = '';

  switch (gender) {
    case 0:
      result = 'Not specified';
      break;
    case 1:
      result = 'Female';
      break;
    case 2:
      result = 'Male';
      break;
    default:
      result = 'Not specified';
      break;
  }

  return result;
}

IconData getIconDataGender(int gender) {
  IconData result;

  switch (gender) {
    case 0:
      result = Icons.nature_people_outlined;
      break;
    case 1:
      result = Icons.female;
      break;
    case 2:
      result = Icons.male;
      break;
    default:
      result = Icons.nature_people_outlined;
      break;
  }

  return result;
}

DateTime? currentBackPressTime;

Future<bool> onWillPop(BuildContext context) {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Press back again to exit', style: kTextSize18w400White),
      backgroundColor: AppColor.background,
    ));
    return Future.value(false);
  }
  return Future.value(true);
}

String checkFirebaseAuthExceptionError(FirebaseAuthException error) {
  String result = '';
  switch (error.code) {
    case 'user-not-found':
      result = 'Your email provided is not registered!';
      break;
    case 'wrong-password':
      result = 'Your password is incorrect!';
      break;
    case 'invalid-email':
      result = 'Invalid email!';
      break;
    case 'email-already-in-use':
      result = 'Email already in use. reset your password or log in!';
      break;
    default:
      result = 'Login information is incorrect!';
  }
  return result;
}
