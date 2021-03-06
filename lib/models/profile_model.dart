import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rssms/api/api_services.dart';

import '/models/entity/user.dart';

class ProfileModel {
  late String errorMsgChangePassword;
  late bool isLoadingChangePassword;
  late bool isLoadingUpdateProfile;
  late ScrollController scrollController;

  late TextEditingController controllerFullname;
  late TextEditingController controllerOldPassword;
  late TextEditingController controllerPassword;
  late TextEditingController controllerConfirmPassword;
  late TextEditingController controllerPhone;
  late TextEditingController controllerStreet;
  late TextEditingController controllerWard;
  late TextEditingController controllerBirthDate;
  late TextEditingController controllerDistrict;
  late FocusNode focusNodeFullname;
  late FocusNode focusNodeOldPassword;
  late FocusNode focusNodePassword;
  late FocusNode focusNodeConfirmPassword;
  late FocusNode focusNodePhone;
  late FocusNode focusNodeStreet;
  late FocusNode focusNodeWard;
  late FocusNode focusNodeBirthDate;
  late FocusNode focusNodeDistrict;
  late String textGender;
  late String errorProfileMsg;
  late String imageUrl;
  late bool isEditAvatar;
  ProfileModel(Users user) {
    errorMsgChangePassword = '';
    errorProfileMsg = '';
    isLoadingChangePassword = false;
    isLoadingUpdateProfile = false;
    scrollController = ScrollController();

    focusNodeFullname = FocusNode();
    focusNodeOldPassword = FocusNode();
    focusNodePassword = FocusNode();
    focusNodeConfirmPassword = FocusNode();
    focusNodePhone = FocusNode();
    focusNodeStreet = FocusNode();
    focusNodeWard = FocusNode();
    focusNodeBirthDate = FocusNode();
    focusNodeDistrict = FocusNode();
    controllerFullname = TextEditingController(text: user.name);
    controllerOldPassword = TextEditingController();
    controllerPassword = TextEditingController();
    controllerConfirmPassword = TextEditingController();
    controllerPhone = TextEditingController(text: user.phone);
    controllerStreet = TextEditingController(text: user.address);
    controllerWard = TextEditingController();
    controllerBirthDate = TextEditingController(
        text: DateFormat("dd/MM/yyyy").format(user.birthDate!));
    controllerDistrict = TextEditingController();
    switch (user.gender) {
      case 0:
        textGender = "Nam";
        break;
      case 1:
        textGender = "N???";
        break;
      case 2:
        textGender = "Nam";
        break;
    }
    imageUrl = user.imageUrl!;
    isEditAvatar = false;
  }

  Future<dynamic> updateProfileDeliveryStaff(int gender, DateTime birthday,
      Map<String, dynamic> image, String idToken, String userId) async {
    try {
      return await ApiServices.updateProfileDeliveryStaff(
          controllerFullname.text,
          controllerPhone.text,
          birthday,
          gender,
          controllerStreet.text,
          idToken,
          userId,
          image);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> updateProfile(
      int gender, DateTime birthday, String idToken, String userId) async {
    try {
      return await ApiServices.updateProfile(
          controllerFullname.text,
          controllerPhone.text,
          birthday,
          gender,
          controllerStreet.text,
          idToken,
          userId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> changePassword(String oldPassword, String confirmPassword,
      String newPassword, String idToken, String userId) async {
    try {
      return await ApiServices.changePassword(
          oldPassword, confirmPassword, newPassword, userId, idToken);
    } catch (e) {
      throw Exception(e);
    }
  }
}
