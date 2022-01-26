import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/dialog_confirm_cancel_model.dart';
import 'package:rssms/views/dialog_confirm_cancel_view.dart';

class DialogConfirmCancelPresenter {
  late DialogConfirmCancelModel model;
  late DialogConfirmCancelView view;

  DialogConfirmCancelPresenter() {
    model = DialogConfirmCancelModel();
  }

  Future<bool> submit(String note, String dateCancel, String idToken) async {
    try {
      view.updateLoading();
      final response =
          await ApiServices.requestCancel(note, 0, dateCancel, idToken);
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw Exception(e);
    } finally {
      view.updateLoading();
    }
  }
}
