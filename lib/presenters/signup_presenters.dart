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

  void handleOnChangeInput(String email, String password,
      String confirmPassword, String firstname, String lastname, String phone) {
    _view!.updateViewStatusButton(
        email, password, confirmPassword, firstname, lastname, phone);
  }

  Future<User?> handleSignIn(String email, String password) async {
    _view!.updateLoading();
    try {
      // final result = await FirebaseServices.firebaseLogin(email, password);
      // print(result);
      // if (result == null) {
      //   _view.updateViewErrorMsg('Invalid username / password');
      //   throw Exception('Invalid email or password');
      // }
      // var response = await ApiServices.logIn(result);
      // response = json.encode(response.data);
      // User user = User.fromJson(json.decode(response));
      // print(user.jwtToken);
      // _model.user = user.copyWith(idTokenFirebase: result);
      // return _model.user;
      return User();
    } catch (e) {
      // print(e.toString());
      // throw Exception('Invalid email or password');
    } finally {
      // _view.updateLoading();
    }
  }
}
