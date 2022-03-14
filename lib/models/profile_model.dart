import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rssms/api/api_services.dart';

import '/models/entity/user.dart';

class ProfileModel {
  String? _errorMsgChangePassword;
  bool? _isLoadingChangePassword;
  bool? _isLoadingUpdateProfile;
  TextEditingController? _controllerFullname;
  TextEditingController? _controllerOldPassword;
  TextEditingController? _controllerPassword;
  TextEditingController? _controllerConfirmPassword;
  TextEditingController? _controllerPhone;
  TextEditingController? _controllerStreet;
  TextEditingController? _controllerWard;
  TextEditingController? _controllerBirthDate;
  TextEditingController? _controllerDistrict;
  String? _textGender;
  String? _textGenderChange;

  ProfileModel(Users user) {
    _errorMsgChangePassword = '';
    _isLoadingChangePassword = false;
    _isLoadingUpdateProfile = false;
    _controllerFullname = TextEditingController(text: user.name);
    _controllerOldPassword = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerPhone = TextEditingController(text: user.phone);
    _controllerStreet = TextEditingController(text: user.address);
    _controllerWard = TextEditingController();
    _controllerBirthDate = TextEditingController(
        text: DateFormat("dd/MM/yyyy").format(user.birthDate!));
    _controllerDistrict = TextEditingController();
    switch (user.gender) {
      case 0:
        _textGender = "Nam";
        break;
      case 1:
        _textGender = "Nữ";
        break;
      case 2:
        _textGender = "Nam";
        break;
    }
    _textGenderChange = _textGender;
  }

  bool get isLoadingChangePassword => _isLoadingChangePassword!;

  set isLoadingChangePassword(bool value) => _isLoadingChangePassword = value;

  bool get isLoadingUpdateProfile => _isLoadingUpdateProfile!;

  set isLoadingUpdateProfile(bool value) => _isLoadingUpdateProfile = value;

  String get errorMsgChangePassword => _errorMsgChangePassword!;

  set errorMsgChangePassword(String value) => _errorMsgChangePassword = value;

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

  get txtGender => _textGender;

  set txtGender(value) => _textGender = value;

  get textGenderChange => _textGenderChange;

  set textGenderChange(value) => _textGenderChange = value;

  Future<dynamic> updateProfile(String name, int gender, DateTime birthday,
      String address, String phone, String idToken, String userId) async {
    return await ApiServices.updateProfile(
        name, phone, birthday, gender, address, idToken, userId);
  }

  Future<dynamic> changePassword(String oldPassword, String confirmPassword,
      String newPassword, String idToken, String userId) async {
    return await ApiServices.changePassword(
        oldPassword, confirmPassword, newPassword, userId, idToken);
  }
}
