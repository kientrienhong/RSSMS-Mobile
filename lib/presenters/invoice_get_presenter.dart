import 'package:rssms/helpers/handle_reponse.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_get_model.dart';
import 'package:rssms/views/invoice_get_view.dart';

class InvoiceGetPresenter {
  late InvoiceGetModel model;
  late InvoiceGetView view;

  InvoiceGetPresenter() {
    model = InvoiceGetModel();
  }
  Future<bool> createRequest(Map<String, dynamic> request, Users user) async {
    view.updateStatusButton();
    try {
      final response = await model.createGetInvoicedRequest(request, user);

      final handledResponse = HandleResponse.handle(response);
      if (handledResponse['status'] == 'success') {
        return true;
      } else {
        view.updateError(handledResponse['data']);
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      view.updateStatusButton();
    }
  }
}
