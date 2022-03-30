import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/api/api_services.dart';
import '/models/entity/user.dart';
import '/models/login_model.dart';
import '/views/login_view.dart';

class LoginPresenter {
  late LoginModel _model;
  late LoginView _view;

  LoginView get view => _view;

  setView(LoginView value) {
    _view = value;
  }

  LoginModel get model => _model;

  LoginPresenter() {
    _model = LoginModel();
  }

  void handleOnChangeInput(String email, String password) {
    _view.updateViewStatusButton(email, password);
  }

  Future<Users?> handleSignIn() async {
    _view.updateLoading();
    try {
      final response = await _model.logInAccount();

      if (response.statusCode == 200) {
        return Users.fromMap(jsonDecode(response.body));
      }

      throw Exception();
    } catch (e) {
      throw Exception('Invalid email or password');
    } finally {
      _view.updateLoading();
    }
  }
}
