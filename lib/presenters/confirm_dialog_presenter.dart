import 'dart:developer';

import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/confirm_dialog_model.dart';
import 'package:rssms/views/confirm_dialog_view.dart';

class ConfirmDialogPresenter {
  late ConfirmDialogModel model;
  late ConfirmDialogView view;
  late Function _confirmFunction;
  ConfirmDialogPresenter(Function confirmFunction) {
    model = ConfirmDialogModel();
    _confirmFunction = confirmFunction;
  }

  Future<bool> onClickConfirm(String id, String idToken) async {
    try {
      view.updateLoading();
      final response = await _confirmFunction();
      final result = ResponseHandle.handle(response);
      if (result['status'] == 'success') {
        return true;
      } else {
        view.updateErrorMsg(result['data']);
        return false;
      }
    } catch (e) {
      log(e.toString());
      view.updateErrorMsg("Xảy ra lỗi hệ thống. Vui lòng thử lại sau");
      return false;
    } finally {
      view.updateLoading();
    }
  }
}
