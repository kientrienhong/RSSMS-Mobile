import 'package:rssms/models/dialog_check_in_model.dart';
import 'package:rssms/views/dialog_confirm_view.dart';

class DialogCheckInPresenter {
  late DialogCheckInModel model;
  late DialogConfirmView view;

  DialogCheckInPresenter() {
    model = DialogCheckInModel();
  }

  Future<bool> checkInDelivery(String idToken, String idRequest) async {
    try {
      view.updateLoading();

      final response = await model.checkInDelivery(idRequest, idToken);
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } finally {
      view.updateLoading();
    }
  }
}
