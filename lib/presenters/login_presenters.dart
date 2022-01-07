import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/api/firebase_services.dart';

import '/api/api_services.dart';
import '/models/entity/user.dart';
import '/models/login_model.dart';
import '/views/login_view.dart';

class LoginPresenter {
  LoginModel? _model;
  LoginView? _view;

  LoginView get view => _view!;

  setView(LoginView value) {
    _view = value;
  }

  LoginModel get model => _model!;

  LoginPresenter() {
    _model = LoginModel();
  }

  void handleOnChangeInput(String email, String password) {
    _view!.updateViewStatusButton(email, password);
  }

  Future<Users?> handleSignInGoogle(String deviceToken) async {
    try {
      _view!.updateLoadingGoogle();

      final googleSignin = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      //Firebase Sign in
      final result = await _model!.auth.signInWithCredential(credential);
      final response =
          await ApiServices.logInThirParty(result.user!.uid, deviceToken);
      print("####################" + result.user!.email!);

      return Users.fromMap(jsonDecode(response.body));
    } catch (error) {
      print(error);
    } finally {
      _view!.updateLoadingGoogle();
    }
  }

  Future<Users?> handleSignInFacebook(String deviceToken) async {
    try {
      _view!.updateLoadingFacebook();

      final res = await _model!.fb!.logIn(permissions: [
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
        final result = await _model!.auth.signInWithCredential(credential);

        final response =
            await ApiServices.logInThirParty(result.user!.uid, deviceToken);

        return Users.fromMap(jsonDecode(response.body));
      }

      return null;
    } catch (error) {
      print(error);
    } finally {
      _view!.updateLoadingFacebook();
    }
  }

  Future<Users?> handleSignIn(
      String email, String password, String deviceToken) async {
    _view!.updateLoading();
    try {
      final response =
          await ApiServices.logInWithEmail(email, password, deviceToken);

      if (response.statusCode == 200) {
        return Users.fromMap(jsonDecode(response.body));
      }

      throw Exception();
    } catch (e) {
      print(e.toString());
      throw Exception('Invalid email or password');
    } finally {
      _view!.updateLoading();
    }
  }
}
