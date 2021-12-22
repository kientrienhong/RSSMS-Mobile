import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:rssms/models/entity/user.dart';

class LoginFacebookController with ChangeNotifier {
  Users? user;
  final _auth = FirebaseAuth.instance;
  final fb = FacebookLogin();

  facebooklogin() async {
    // var result = await FacebookAuth.i.login(
    //   permissions: ["public_profile", "email"],
    // );

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);

    // check the status of our login
    if (res.status == FacebookLoginStatus.success) {
      final FacebookAccessToken? fbToken = res.accessToken;

      //Convert to Auth Credential
      final AuthCredential credential =
          FacebookAuthProvider.credential(fbToken!.token);

      //User Credential to Sign in with Firebase
      final result = await _auth.signInWithCredential(credential);

      print('${result.user!.displayName} is now logged in');

      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );

      user = Users(
        name: requestData["name"],
        email: requestData["email"],
        avatar: requestData["picture"]["data"]["url"] ?? " ",
        phone: requestData["phone"],
      );
      notifyListeners();
    }
  }

  // logout

  logout() async {
    //this.googleSignInAccount = await _googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    user = null;
    notifyListeners();
  }
}
