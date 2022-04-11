import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';

import '/models/entity/user.dart';

class SignUpModel {
  late bool isDisableSignup;
  late String errorMsg;
  late bool isLoading;
  late TextEditingController controllerEmail;
  late TextEditingController controllerAddress;
  late TextEditingController controllerPassword;
  late TextEditingController controllerConfirmPassword;
  late TextEditingController controllerPhone;
  late TextEditingController controllerName;
  late TextEditingController controllerBirthDate;
  late FocusNode focusNodeEmail;
  late FocusNode focusNodePassword;
  late FocusNode focusNodeConfirmPassword;
  late FocusNode focusNodeAddress;
  late FocusNode focusNodePhone;
  late FocusNode focusNodeName;
  late FocusNode focusNodeBirthDate;
  late int gender;
  late String token;
  SignUpModel() {
    isDisableSignup = true;
    errorMsg = '';
    token = '';
    gender = 0;
    isLoading = false;
    controllerEmail = TextEditingController();
    controllerAddress = TextEditingController();
    controllerPassword = TextEditingController();
    controllerConfirmPassword = TextEditingController();
    controllerPhone = TextEditingController();
    controllerName = TextEditingController();
    controllerBirthDate = TextEditingController();
    focusNodeEmail = FocusNode();
    focusNodePassword = FocusNode();
    focusNodeConfirmPassword = FocusNode();
    focusNodeAddress = FocusNode();
    focusNodePhone = FocusNode();
    focusNodeName = FocusNode();
    focusNodeBirthDate = FocusNode();
  }

  Future<dynamic> signUp(Users user, String password, String role, String image,
      String deviceToken) async {
    try {
      return await ApiServices.signUp(user, password, role, image, deviceToken);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getRoles() async {
    try {
      return await ApiServices.getRoles();
    } catch (e) {
      throw Exception(e);
    }
  }
}
