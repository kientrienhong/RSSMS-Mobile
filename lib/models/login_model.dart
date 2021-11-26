import '/models/entity/user.dart';

class LoginModel {
  bool? _isDisableLogin;
  String? _errorMsg;
  bool? _isLoading;
  User? _user;

  LoginModel() {
    _isDisableLogin = true;
    _errorMsg = '';
    _isLoading = false;
    _user = User.empty();
  }
  get user => _user;

  set user(value) => _user = value;

  bool get isLoading => _isLoading!;

  set isLoading(bool value) => _isLoading = value;

  String get errorMsg => _errorMsg!;

  set errorMsg(String value) => _errorMsg = value;

  get isDisableLogin => _isDisableLogin;

  set isDisableLogin(value) => _isDisableLogin = value;
}
