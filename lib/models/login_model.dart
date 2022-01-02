import '/models/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginModel {
  bool? _isDisableLogin;
  String? _errorMsg;
  bool? _isLoading;
  Users? _user;
  FirebaseAuth? _auth;

  LoginModel() {
    _isDisableLogin = true;
    _errorMsg = '';
    _isLoading = false;
    _user = Users.empty();
    _auth = FirebaseAuth.instance;
  }
  get user => _user;

  set user(value) => _user = value;

  bool get isLoading => _isLoading!;

  set isLoading(bool value) => _isLoading = value;

  String get errorMsg => _errorMsg!;

  set errorMsg(String value) => _errorMsg = value;

  get isDisableLogin => _isDisableLogin;

  set isDisableLogin(value) => _isDisableLogin = value;

  FirebaseAuth get auth => this._auth!;

  set auth(FirebaseAuth value) => this._auth = value;
}
