import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';

import '/models/entity/user.dart';

class SignUpModel {
  bool? _isDisableSignup;
  String? _errorMsg;
  bool? _isLoading;
  TextEditingController? _controllerEmail;
  TextEditingController? _controllerAddress;
  TextEditingController? _controllerPassword;
  TextEditingController? _controllerConfirmPassword;
  TextEditingController? _controllerPhone;
  TextEditingController? _controllerName;
  TextEditingController? _controllerBirthDate;

  SignUpModel() {
    _isDisableSignup = true;
    _errorMsg = '';
    _isLoading = false;
    _controllerEmail = TextEditingController();
    _controllerAddress = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerName = TextEditingController();
    _controllerBirthDate = TextEditingController();
  }

  bool get isLoading => _isLoading!;

  set isLoading(bool value) => _isLoading = value;

  String get errorMsg => _errorMsg!;

  set errorMsg(String value) => _errorMsg = value;

  get isDisableSignup => _isDisableSignup;

  set isDisableSignup(value) => _isDisableSignup = value;

  get controllerEmail => _controllerEmail;

  set controllerEmail(value) => _controllerEmail = value;

  get controllerAddress => _controllerAddress;

  set controllerAddress(value) => _controllerAddress = value;

  get controllerPassword => _controllerPassword;

  set controllerPassword(value) => _controllerPassword = value;

  get controllerConfirmPassword => _controllerConfirmPassword;

  set controllerConfirmPassword(value) => _controllerConfirmPassword = value;

  get controllerPhone => _controllerPhone;

  set controllerPhone(value) => _controllerPhone = value;

  get controllerName => _controllerName;

  set controllerName(value) => _controllerName = value;

  get controllerBirthDate => _controllerBirthDate;

  set controllerBirthDate(value) => _controllerBirthDate = value;

  Future<dynamic> signUp(Users user, String password, String role, String image,
      String deviceToken) async {
    return await ApiServices.signUp(user, password, role, image, deviceToken);
  }

  Future<dynamic> getRoles() async {
    return await ApiServices.getRoles();
  }
}
