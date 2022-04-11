import 'dart:convert';

import 'package:rssms/helpers/handle_reponse.dart';

import '/models/entity/user.dart';
import '/models/login_model.dart';
import '/views/login_view.dart';

class LoginPresenter {
  late LoginModel _model;
  late LoginView _view;

  LoginView get view => _view;

  setView(LoginView value) {
    _view = value;
  }

  LoginModel get model => _model;

  LoginPresenter() {
    _model = LoginModel();
  }

  void handleOnChangeInput(String email, String password) {
    _view.updateViewStatusButton(email, password);
  }

  Future<Users?> handleSignIn() async {
    _view.updateLoading();
    try {
      final response = await _model.logInAccount();

      final handledResponse = HandleResponse.handle(response);

      if (handledResponse['status'] == 'success') {
        return Users.fromMap(handledResponse['data']);
      } else {
        _view.updateViewErrorMsg(handledResponse['data']);
        return null;
      }
    } catch (e) {
      _view.updateViewErrorMsg("Xảy ra lỗi hệ thống. Vui lòng thử lại sau");
    } finally {
      _view.updateLoading();
    }
  }
}
