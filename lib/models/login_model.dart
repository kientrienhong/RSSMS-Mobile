import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';
import '/models/entity/user.dart';

class LoginModel {
  late bool isDisableLogin;
  late String errorMsg;
  late bool isLoading;
  late bool isLoadingGoogle;
  late bool isLoadingFacebook;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  late String deviceToken;
  late FocusNode focusNodeEmail;
  late FocusNode focusNodePassword;
  late Users user;
  LoginModel() {
    isDisableLogin = true;
    errorMsg = '';
    isLoading = false;
    isLoadingFacebook = false;
    isLoadingGoogle = false;
    user = Users.empty();
    focusNodeEmail = FocusNode();
    focusNodePassword = FocusNode();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
  }

  String get _email => controllerEmail.text;
  String get _password => controllerPassword.text;

  Future<dynamic> logInAccount() async {
    try {
      return await ApiServices.logInWithEmail(_email, _password, deviceToken);
    } catch (e) {
      throw Exception(e);
    }
  }
}
