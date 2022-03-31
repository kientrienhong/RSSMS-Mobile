import 'package:rssms/models/dialog_confirm_model.dart';
import 'package:rssms/views/dialog_confirm_view.dart';

class DialogConfirmPresenter {
  late DialogConfirmModel model;
  late DialogConfirmView view;

  DialogConfirmPresenter() {
    model = DialogConfirmModel();
  }

  Future<bool> submit(String note, String dateCancel, String idToken) async {
    try {
      view.updateLoading();
      final response = await model.requestCancel(note, dateCancel, idToken);
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

  Future<bool> onClickReport(
      String note, String idRequest, String idToken) async {
    try {
      view.updateLoading();
      final response = await model.updateRequest(note, idToken, idRequest);
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
