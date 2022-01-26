import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_get_model.dart';
import 'package:rssms/views/invoice_get_view.dart';

class InvoiceGetPresenter {
  late InvoiceGetModel model;
  late InvoiceGetView view;

  InvoiceGetPresenter() {
    model = InvoiceGetModel();
  }
  Future<bool> createRequest(
      Map<String, dynamic> request, Users user) async {
    view.updateStatusButton();
    try {
      final response =
          await ApiServices.createGetInvoicedRequest(request, user);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      view.updateStatusButton();
    }
  }
}
