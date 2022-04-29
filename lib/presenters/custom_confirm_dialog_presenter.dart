import 'dart:developer';

import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/custom_confirm_dialog_model.dart';
import 'package:rssms/views/custom_confirm_dialog_view.dart';

class CustomConfirmDialogPresenter {
  late CustomConfirmDialogModel model;
  late CustomConfirmDialogView view;

  CustomConfirmDialogPresenter(Function onSubmit) {
    model = CustomConfirmDialogModel(onSubmit);
  }

  Future<bool> onPressSubmit() async {
    try {
      view.updateLoading();
      final response = await model.onSubmit(model.controller.text);

      final result = ResponseHandle.handle(response);
      if (result['status'] == 'success') {
        return true;
      } else {
        view.updateError(result['data']);
        return false;
      }
    } catch (e) {
      log(e.toString());
      view.updateError(e.toString());
      return false;
    } finally {
      view.updateLoading();
    }
  }
}
