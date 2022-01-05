import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/profile_model.dart';
import 'package:rssms/views/profile_view.dart';

import '/models/entity/user.dart';

class ProfilePresenter {
  ProfileModel? _model;
  ProfileView? _view;

  ProfileView get view => _view!;

  setView(ProfileView value) {
    _view = value;
  }

  ProfileModel get model => _model!;

  ProfilePresenter(Users user) {
    _model = ProfileModel(user);
  }

  void handleOnChangeInputChangePassword(
      String oldPassword, String newPassword, String confirmPassword) {
    _view!.updateStatusOfButtonChangePassword(
        oldPassword, newPassword, confirmPassword);
  }

  void handleOnChangeInputProfile(
      String fullname, String phone, String address) {
    _view!.updateStatusOfButtonUpdateProfile(fullname, phone, address);
  }
  // void handleOnChangeInput(String email, String password,
  //     String confirmPassword, String firstname, String lastname, String phone) {
  //   _view!.updateViewStatusButton(
  //       email, password, confirmPassword, firstname, lastname, phone);
  // }

  Future<bool> updateProfile(String name, int gender, DateTime birthday,
      String address, String phone, String idToken, int userId) async {
    _view!.updateLoadingProfile();

    try {
      final response = await ApiServices.updateProfile(
          name, phone, birthday, gender, address, idToken, userId);

      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    } finally {
      _view!.updateLoadingPassword();
    }
  }

  Future<bool> changePassword(String newPassword, String oldPassword,
      String confirmPassword, String idToken, int userId) async {
    _view!.updateLoadingPassword();
    try {
      if (newPassword != confirmPassword) {
        throw Exception(
            "Vui lòng nhập mật khẩu mới trùng với xác nhận mật khẩu");
      }
      final response = await ApiServices.changePassword(
          oldPassword, confirmPassword, newPassword, userId, idToken);

      if (response.statusCode == 200) return true;

      return false;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    } finally {
      _view!.updateLoadingPassword();
    }
  }
}
