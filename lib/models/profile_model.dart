import 'package:flutter/cupertino.dart';

import '/models/entity/user.dart';

class ProfileModel {
  bool? _isDisableUpdate;
  String? _errorMsg;
  bool? _isLoading;
  TextEditingController? _controllerFullname;
  TextEditingController? _controllerOldPassword;
  TextEditingController? _controllerPassword;
  TextEditingController? _controllerConfirmPassword;
  TextEditingController? _controllerPhone;
  TextEditingController? _controllerStreet;
  TextEditingController? _controllerWard;
  TextEditingController? _controllerBirthDate;
  TextEditingController? _controllerDistrict;

  ProfileModel(Users user) {
    _isDisableUpdate = true;
    _errorMsg = '';
    _isLoading = false;
    _controllerFullname = TextEditingController(text: user.name);
    _controllerOldPassword = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerPhone = TextEditingController(text: user.phone);
    _controllerStreet = TextEditingController(text: user.address);
    _controllerWard = TextEditingController();
    _controllerBirthDate = TextEditingController();
    _controllerDistrict = TextEditingController();
  }

  bool get isLoading => _isLoading!;

  set isLoading(bool value) => _isLoading = value;

  String get errorMsg => _errorMsg!;

  set errorMsg(String value) => _errorMsg = value;

  get isDisableUpdate => _isDisableUpdate;

  set isDisableUpdate(value) => _isDisableUpdate = value;

  get controllerFullname => _controllerFullname;

  set controllerFullname(value) => _controllerFullname = value;

  get controllerOldPassword => _controllerOldPassword;

  set controllerOldPassword(value) => _controllerOldPassword = value;

  get controllerPassword => _controllerPassword;

  set controllerPassword(value) => _controllerPassword = value;

  get controllerConfirmPassword => _controllerConfirmPassword;

  set controllerConfirmPassword(value) => _controllerConfirmPassword = value;

  get controllerPhone => _controllerPhone;

  set controllerPhone(value) => _controllerPhone = value;

  get controllerStreet => _controllerStreet;

  set controllerStreet(value) => _controllerStreet = value;

  get controllerWard => _controllerWard;

  set controllerWard(value) => _controllerWard = value;

  get controllerBirthDate => _controllerBirthDate;

  set controllerBirthDate(value) => _controllerBirthDate = value;

  get controllerDistrict => _controllerDistrict;

  set controllerDistrict(value) => _controllerDistrict = value;
}
