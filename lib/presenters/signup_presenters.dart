import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/signup_model.dart';
import 'package:rssms/views/signup_view.dart';

import '/models/entity/user.dart';

class SignUpPresenter {
  SignUpModel? _model;
  SignUpView? _view;

  SignUpView get view => _view!;

  setView(SignUpView value) {
    _view = value;
  }

  SignUpModel get model => _model!;

  SignUpPresenter() {
    _model = SignUpModel();
  }

  void handleOnChangeInput(
      String email,
      String password,
      String confirmPassword,
      String address,
      String name,
      String phone,
      String birthDay) {
    _view!.updateViewStatusButton(
        email, password, confirmPassword, address, name, phone, birthDay);
  }

  Future<dynamic> handleSignUp(
      Users user, String password, String deviceToken, String roleId) async {
    _view!.updateLoading();
    try {
      final response = await model.signUp(user, password, deviceToken, roleId);

      if (response.statusCode == 200) {
        return Users.fromMap(jsonDecode(response.body));
      }
      print(response.body["error"]["message"]);
      throw Exception(response.body.toString());
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      _view!.updateLoading();
    }
  }
}