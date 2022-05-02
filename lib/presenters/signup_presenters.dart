import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/signup_model.dart';
import 'package:rssms/views/signup_view.dart';
import 'package:path_provider/path_provider.dart';

import '/models/entity/user.dart';

class SignUpPresenter {
  late SignUpModel model;
  late SignUpView view;

  setView(SignUpView value) {
    view = value;
    model.controllerEmail.addListener(view.onChangeInput);
    model.controllerPassword.addListener(view.onChangeInput);
    model.controllerConfirmPassword.addListener(view.onChangeInput);
    model.controllerPhone.addListener(view.onChangeInput);
    model.controllerName.addListener(view.onChangeInput);
    model.controllerBirthDate.addListener(view.onChangeInput);
  }

  SignUpPresenter() {
    model = SignUpModel();
  }

  void handleOnChangeInput() {
    view.updateViewStatusButton(
        model.controllerEmail.text,
        model.controllerPassword.text,
        model.controllerConfirmPassword.text,
        model.controllerAddress.text,
        model.controllerName.text,
        model.controllerPhone.text,
        model.controllerBirthDate.text);
  }

  Future<Users?> handleSignUp() async {
    view.updateLoading();
    unfocusAllFocusNode();
    model.errorMsg = "";

    try {
      Users user = Users.register(
          address: model.controllerAddress.text,
          birthDate:
              DateFormat('dd/MM/yyyy').parse(model.controllerBirthDate.text),
          email: model.controllerEmail.text,
          gender: model.gender,
          name: model.controllerName.text,
          phone: model.controllerPhone.text);
      String avatar = 'assets/images/profile.png';
      ByteData bytes = await rootBundle.load(avatar);
      final file = File('${(await getTemporaryDirectory()).path}/profile.png');

      File newFile = await file.writeAsBytes(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      List<int> imageBytes = await newFile.readAsBytes();
      final responseGetRole = await model.getRoles();

      // jsonDecode(responseGetRole.body)['data'][0]['id'];

      final response = await model.signUp(
          user,
          model.controllerPassword.text,
          jsonDecode(responseGetRole.body)['data'][0]['id'],
          base64Encode(imageBytes),
          model.token);

      final result = ResponseHandle.handle(response);

      if (result['status'] == 'success') {
        return Users.fromMap(result['data']);
      } else {
        view.updateViewErrorMsg(result['data']);
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      view.updateLoading();
    }
  }

  void unfocusAllFocusNode() {
    model.focusNodePassword.unfocus();
    model.focusNodeAddress.unfocus();
    model.focusNodeBirthDate.unfocus();
    model.focusNodeConfirmPassword.unfocus();
    model.focusNodeEmail.unfocus();
    model.focusNodeName.unfocus();
    model.focusNodePhone.unfocus();
  }

  void dispose() {
    model.focusNodeEmail.dispose();
    model.focusNodePassword.dispose();
    model.focusNodeConfirmPassword.dispose();
    model.focusNodeName.dispose();
    model.focusNodeBirthDate.dispose();
    model.focusNodePhone.dispose();
  }
}
