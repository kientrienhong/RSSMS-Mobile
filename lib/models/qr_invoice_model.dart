import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';

class QRInvoiceModel {
  Invoice? invoice;

  void loadInvoice(String idtoken) {}

  Future<dynamic> loadRequest(String idToken, String id) async {
    return await ApiServices.getRequestbyId(idToken, id);
  }
}
