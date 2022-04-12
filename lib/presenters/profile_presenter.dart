import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/profile_model.dart';
import 'package:rssms/views/profile_view.dart';

import '/models/entity/user.dart';

class ProfilePresenter {
  late ProfileModel model;
  late ProfileView view;

  setView(ProfileView value) {
    view = value;
  }

  ProfilePresenter(Users user) {
    model = ProfileModel(user);
  }

  Future<bool> updateProfile(String idToken, String userId) async {
    try {
      view.updateLoadingProfile();
      model.focusNodeStreet.unfocus();
      model.focusNodePhone.unfocus();
      model.focusNodeFullname.unfocus();
      int genderCode;
      switch (model.textGender) {
        case "Nam":
          genderCode = 0;
          break;
        case "Nữ":
          genderCode = 1;
          break;
        default:
          genderCode = 2;
          break;
      }
      DateTime tempDate =
          DateFormat("dd/MM/yyyy").parse(model.controllerBirthDate.text);
      final response =
          await model.updateProfile(genderCode, tempDate, idToken, userId);
      final handledResponse = ResponseHandle.handle(response);
      if (handledResponse['status'] == 'success') {
        return true;
      } else {
        view.updateErrorProfile(handledResponse['data']);
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      view.updateLoadingProfile();
    }
  }

  void dispose() {
    model.focusNodeFullname.dispose();
    model.focusNodeOldPassword.dispose();
    model.focusNodePassword.dispose();
    model.focusNodeConfirmPassword.dispose();
    model.focusNodeStreet.dispose();
    model.focusNodeWard.dispose();
    model.focusNodeDistrict.dispose();
    model.focusNodeBirthDate.dispose();
    model.focusNodePhone.dispose();
    model.controllerFullname.dispose();
    model.controllerOldPassword.dispose();
    model.controllerPassword.dispose();
    model.controllerConfirmPassword.dispose();
    model.controllerStreet.dispose();
    model.controllerWard.dispose();
    model.controllerDistrict.dispose();
    model.controllerPhone.dispose();
    model.controllerBirthDate.dispose();
  }

  Future<bool> changePassword(String newPassword, String oldPassword,
      String confirmPassword, String idToken, String userId) async {
    view.updateLoadingPassword();
    try {
      model.errorMsgChangePassword = "";
      final response = await model.changePassword(
          oldPassword, confirmPassword, newPassword, idToken, userId);

      final handledResponse = ResponseHandle.handle(response);

      if (handledResponse['status'] == 'success') {
        model.controllerConfirmPassword.text = "";
        model.controllerPassword.text = "";
        model.controllerOldPassword.text = "";
        return true;
      } else {
        view.updateViewPasswordErrorMsg(handledResponse['data']);
        return false;
      }
    } catch (e) {
      log(e.toString());
      view.updateViewPasswordErrorMsg(
          "Xảy ra lỗi hệ thống. Vui lòng thử lại sau");
      return false;
    } finally {
      view.updateLoadingPassword();
    }
  }
}
