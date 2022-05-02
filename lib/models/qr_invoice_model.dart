import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/request.dart';

class QRInvoiceModel {
  late Invoice invoice;
  late List<Request> listRequest;
  QRInvoiceModel() {
    invoice = Invoice.empty();
    listRequest = [];
  }

  Future<dynamic> loadRequest(String idToken, String id) async {
    return await ApiServices.getRequestbyId(idToken, id);
  }
}
