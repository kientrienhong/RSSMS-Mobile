import '/models/entity/user.dart';

class ProfileModel {
  bool? _isDisableUpdate;
  String? _errorMsg;
  bool? _isLoading;
  User? _user;

  ProfileModel() {
    _isDisableUpdate = true;
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

  get isDisableUpdate => _isDisableUpdate;

  set isDisableUpdate(value) => _isDisableUpdate = value;
}
