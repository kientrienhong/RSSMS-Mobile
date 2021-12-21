import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:rssms/models/login_google_model.dart';

class LoginGoogle extends ChangeNotifier {
  final authService = LoginGoogleModel();
  final googleSignin = GoogleSignIn();
  Stream<User?> get currentUser => authService.currentUser;

  Future loginGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      //Firebase Sign in
      final result = await authService.signInWithCredential(credential);

      print('${result.user!.displayName}');
      print('${result.user!.email}');
      print('${result.user!.phoneNumber}');
      print('${result.user!.photoURL}');
      print('${result.user!.uid}');
      print('${result.user!.metadata}');
      //print('${result.user.providerData}');
      print('${result.user!.refreshToken}');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future logout() async {
    await googleSignin.disconnect();
    authService.logout();
  }
}
