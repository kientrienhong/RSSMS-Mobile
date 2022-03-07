import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_cancel_model.dart';
import 'package:rssms/views/invoice_cancel_view.dart';

class InvoiceCancelPresenter {
  late InvoiceCancelModel model;
  late InvoiceCancelView view;

  InvoiceCancelPresenter() {
    model = InvoiceCancelModel();
  }

  Future<bool> createRequest(
      Map<String, dynamic> cancelRequest, Users user, Invoice invoice) async {
    view.updateLoadingCancel();
    try {
      final response =
          await ApiServices.createCancelRequest(cancelRequest, user, invoice);

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode >= 500) {
        throw Exception("Máy chủ bị lỗi vui lòng thử lại sau");
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      view.updateLoadingCancel();
    }
  }
}
