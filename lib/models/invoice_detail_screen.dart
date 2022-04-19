import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';

class InvoiceDetailScreenModel {
  late Invoice invoice;
  late Invoice orginalInvoice;
  late Invoice showUIInvoice;
  late bool isLoading;
  InvoiceDetailScreenModel() {
    invoice = Invoice.empty();
    showUIInvoice = Invoice.empty();
    orginalInvoice = Invoice.empty();
    isLoading = true;
  }

  Future<dynamic> loadingDetailInvoice(String id, String idToken) async {
    return await ApiServices.getInvoicebyId(idToken, id);
  }
}
