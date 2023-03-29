import 'package:firebase_auth/firebase_auth.dart';

class UserAPI{
  Future<void> uploadAvatar(User user,String? imageURL) async{
    try{
      await user.updatePhotoURL(imageURL);
    }catch (error, stacktrace) {
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<void> updateProfile(User user, String name) async {
    try {

      await user.updateDisplayName(name);
    } catch (error, stacktrace) {
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<void> updatePassword(User user,String newPassword) async{
    try{
      await user.updatePassword(newPassword);
    }catch (error, stacktrace) {
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }
}