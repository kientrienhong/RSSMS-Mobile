import 'package:rssms/helpers/handle_reponse.dart';

import '/models/entity/user.dart';
import '/models/login_model.dart';
import '/views/login_view.dart';

class LoginPresenter {
  late LoginModel model;
  late LoginView view;

  setView(LoginView value) {
    view = value;
  }

  LoginPresenter() {
    model = LoginModel();
  }

  void handleOnChangeInput(String email, String password) {
    view.updateViewStatusButton(email, password);
  }

  Future<Users?> handleSignIn() async {
    view.updateLoading();
    model.focusNodeEmail.unfocus();
    model.focusNodePassword.unfocus();
    model.errorMsg = '';
    try {
      final response = await model.logInAccount();

      final handledResponse = HandleResponse.handle(response);

      if (handledResponse['status'] == 'success') {
        return Users.fromMap(handledResponse['data']);
      } else {
        view.updateViewErrorMsg(handledResponse['data']);
        return null;
      }
    } catch (e) {
      view.updateViewErrorMsg("Xảy ra lỗi hệ thống. Vui lòng thử lại sau");
    } finally {
      view.updateLoading();
    }
  }

  void dispose() {
    model.controllerEmail.dispose();
    model.controllerPassword.dispose();
    model.focusNodeEmail.dispose();
    model.focusNodePassword.dispose();
  }
}
