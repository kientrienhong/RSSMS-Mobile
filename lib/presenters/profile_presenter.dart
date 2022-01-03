import 'package:rssms/models/profile_model.dart';
import 'package:rssms/models/signup_model.dart';
import 'package:rssms/views/profile_view.dart';
import 'package:rssms/views/signup_view.dart';

import '/models/entity/user.dart';

class ProfilePresenter {
  ProfileModel? _model;
  ProfileView? _view;

  ProfileView get view => _view!;

  setView(ProfileView value) {
    _view = value;
  }

  ProfileModel get model => _model!;

  ProfilePresenter() {
    _model = ProfileModel();
  }

  // void handleOnChangeInput(String email, String password,
  //     String confirmPassword, String firstname, String lastname, String phone) {
  //   _view!.updateViewStatusButton(
  //       email, password, confirmPassword, firstname, lastname, phone);
  // }

  Future<Users?> handleSignIn(String email, String password) async {
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
      return Users.empty();
    } catch (e) {
      // print(e.toString());
      // throw Exception('Invalid email or password');
    } finally {
      // _view.updateLoading();
    }
  }
}
