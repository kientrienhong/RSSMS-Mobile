import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
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

  Future<Users?> handleSignInGoogle() async {
    try {
      _view!.updateLoading();

      final googleSignin = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      //Firebase Sign in
      final result = await _model!.auth.signInWithCredential(credential);

      print('${result.user!.displayName}');
      print('${result.user!.email}');
      print('${result.user!.phoneNumber}');
      print('${result.user!.photoURL}');
      print('${result.user!.uid}');
      print('${result.user!.metadata}');
      //print('${result.user.providerData}');
      print('${result.user!.refreshToken}');
    } catch (error) {
      print(error);
    } finally {
      _view!.updateLoading();
    }
  }

  Future<Users?> handleSignIn(String email, String password) async {
    _view!.updateLoading();
    try {
      // final result = await FirebaseServices.firebaseLogin(email, password);
      // print(result);
      // if (result == null) {
      //   _view.updateViewErrorMsg('Invalid username / password');
      //   throw Exception('Invalid email or password');
      // }
      // var response = await ApiServices.logIn(result);
      // response = json.encode(response.data);
      // User user = User.fromJson(json.decode(response));
      // print(user.jwtToken);
      // _model.user = user.copyWith(idTokenFirebase: result);
      // return _model.user;
      return Users();
    } catch (e) {
      // print(e.toString());
      // throw Exception('Invalid email or password');
    } finally {
      // _view.updateLoading();
    }
  }
}
