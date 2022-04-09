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

      String? result = HandleResponse.handle(response);
      if (result != null) {
        view.updateError(result);
      }

      return result == null;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      view.updateStatusButton();
    }
  }
}
