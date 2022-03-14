import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:rssms/api/api_services.dart';

import '/models/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginModel {
  bool? _isDisableLogin;
  String? _errorMsg;
  bool? _isLoading;
  bool? _isLoadingGoogle;
  bool? _isLoadingFacebook;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  late String deviceToken;
  String get _email => controllerEmail.text;
  String get _password => controllerPassword.text;
  Users? _user;
  FirebaseAuth? _auth;
  FacebookLogin? _fb;

  LoginModel() {
    _isDisableLogin = true;
    _errorMsg = '';
    _isLoading = false;
    _isLoadingFacebook = false;
    _isLoadingGoogle = false;
    _user = Users.empty();
    _auth = FirebaseAuth.instance;
    _fb = FacebookLogin();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
  }
  get user => _user;

  set user(value) => _user = value;

  bool get isLoading => _isLoading!;

  set isLoading(bool value) => _isLoading = value;

  String get errorMsg => _errorMsg!;

  set errorMsg(String value) => _errorMsg = value;

  get isDisableLogin => _isDisableLogin;

  set isDisableLogin(value) => _isDisableLogin = value;

  FirebaseAuth get auth => _auth!;

  set auth(FirebaseAuth value) => _auth = value;

  get isLoadingGoogle => _isLoadingGoogle;

  set isLoadingGoogle(value) => _isLoadingGoogle = value;

  get isLoadingFacebook => _isLoadingFacebook;

  set isLoadingFacebook(value) => _isLoadingFacebook = value;

  FacebookLogin? get fb => _fb;

  set fb(FacebookLogin? value) => _fb = value;

  Future<dynamic> logInAccount() async {
    return await ApiServices.logInWithEmail(_email, _password, deviceToken);
  }
}
