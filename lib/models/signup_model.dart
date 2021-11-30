import '/models/entity/user.dart';

class SignUpModel {
  bool? _isDisableSignup;
  String? _errorMsg;
  bool? _isLoading;
  User? _user;

  SignUpModel() {
    _isDisableSignup = true;
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

  get isDisableSignup => _isDisableSignup;

  set isDisableSignup(value) => _isDisableSignup = value;
}
