import 'package:shared_preferences/shared_preferences.dart';

class HelperSharedPreferences{
  // SHA1 hash
  static const String uidKey = 'e2577dd78b54fe28c65ee56ffbc8bb73058e08c0';
  static const String tokenKey = 'ee977806d7286510da8b9a7492ba58e2484c0ecc';
  static const String expirationTimeKey = 'df9c6b800e1b7d06f4aa73da461dcaeb51bbceaf';
  static const String isLoginKey = '701a9638123cb030fe067f6b674bc742ec0b66eb';
  static const String loginTypeKey = '89622b41902bdfa5503e7ffea49deb329b50152a';

  // save
  static Future<bool> saveUid(String uid) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(uidKey, uid);
  }
  static Future<bool> saveToken(String token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(tokenKey, token);
  }
  static Future<bool> saveExpirationTime(int expirationTime) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(expirationTimeKey, expirationTime);
  }
  static Future<bool> saveLogin(bool isLogin) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(isLoginKey, isLogin);
  }
  // login type: 0 => login with email and password
  // login type: 1 => login with google
  // login type: 2 => login with facebook
  static Future<bool> saveLoginType(int loginType) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(loginTypeKey, loginType);
  }

  // get
  static Future<String?> getUid() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(uidKey);
  }
  static Future<String?> getToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(tokenKey);
  }
  static Future<int?> getExpirationTime() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(expirationTimeKey);
  }
  static Future<bool?> getLogin() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isLoginKey);
  }
  static Future<int?> getLoginType() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(loginTypeKey);
  }
}