import 'package:application/models/models.dart';
import 'package:application/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var idTokenResult = await userCredential.user?.getIdTokenResult();
      String uid = userCredential.user?.uid ?? '';
      String token = idTokenResult!.token ?? '';
      int expirationTime = idTokenResult.expirationTime!.millisecondsSinceEpoch;

      return Authentication(
          uid: uid, token: token, expiredToken: expirationTime);
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      var idTokenResult = await userCredential.user?.getIdTokenResult();
      String uid = userCredential.user?.uid ?? '';
      String token = idTokenResult!.token ?? '';
      int expirationTime = idTokenResult.expirationTime!.millisecondsSinceEpoch;

      return Authentication(
          uid: uid, token: token, expiredToken: expirationTime);
    } on FirebaseAuthException catch (e) {
      debugPrint('code: ${e.code}');

      return e;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  Future signOut() async => _auth.signOut();

  Future sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      showDialog(context: context, builder: (context) => const LoadingDialog());

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  Future<User?> signInWithFacebook({required BuildContext context}) async {
    User? user;

    final fb = FacebookLogin();

    // Log in
    final facebookSignInAccount = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (facebookSignInAccount.status) {
      case FacebookLoginStatus.success:
        final AuthCredential credential = FacebookAuthProvider.credential(
            facebookSignInAccount.accessToken?.token ?? '');
        try {
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            debugPrint(e.code);
          } else if (e.code == 'invalid-credential') {
            debugPrint(e.code);
            // handle the error here
          }
        } catch (e) {
          // handle the error here
        }
        break;

      case FacebookLoginStatus.cancel:
        // User cancel log in
        debugPrint('cancel:');
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        debugPrint('Error while log in: ${facebookSignInAccount.error}');
        break;
    }

    return user;
  }
}
